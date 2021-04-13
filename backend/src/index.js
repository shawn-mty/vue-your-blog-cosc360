const { upload } = require('./middleware/multer')
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const { PrismaClient } = require('@prisma/client')
const session = require('express-session')
const bcrypt = require('bcrypt')
const saltRounds = 10
const serveIndex = require('serve-index')

// // check if passwords match
// console.log(
//   'these passwords match? ' +
//     bcrypt.compareSync(
//       'u78987u',
//       '$2b$10$pMATEIQpXR7M12ItstRTMuEbUw3Ehluix2gW3LXoqBz8.JGrTkeXq'
//     )
// )

const prisma = new PrismaClient()
const app = express()
app.use(
  session({
    secret: 'meow-meow-meow',
    resave: false,
    saveUninitialized: false,
    cookie: {
      httpOnly: false,
      secure: false,
      maxAge: 720000,
    },
  })
)

app.use(
  cors({
    origin: 'http://localhost:8080',
    credentials: true,
  })
)
app.use(bodyParser.json())
const path = require('path')
app.use(
  '/uploads',
  express.static(path.join(__dirname, '..', 'uploads')),
  serveIndex(path.join(__dirname, '..', 'uploads'))
)

// create user in database and return response
app.post('/create-user', upload.single('image'), async (req, res, next) => {
  const hashedPass = bcrypt.hashSync(req.body.password, saltRounds)
  const dbData = {
    email: req.body.email,
    username: req.body.username,
    password: hashedPass,
    profileImagePath: req.file.path,
    isAdmin: 0,
  }
  try {
    const result = await prisma.user.create({
      data: dbData,
    })
    res.json(result)
  } catch (err) {
    res.status(500).send(err)
  }
})

// create post in database and return response
app.post('/create-blog', upload.array('images'), async (req, res) => {
  const blogElementTypesOrderString = req.body.blogElementTypesOrder
  const images = req.files
  let textAreas = []
  if (typeof req.body.textAreas === 'string') {
    textAreas.push({ textArea: req.body.textAreas })
  } else if (Array.isArray(req.body.textAreas)) {
    textAreas = req.body.textAreas.map((textArea) => {
      return { textArea: textArea }
    })
  } else {
    throw new Error('textArea has wrong type')
  }

  const imagePaths = images
    ? images.map((image) => {
        return { imagePath: image.path }
      })
    : []

  const dbData = {
    title: req.body.title,
    orderOfElements: blogElementTypesOrderString,
    user: { connect: { id: 1 } }, // TODO add actual user after login feature built
    blog_imagepaths: {
      create: imagePaths,
    },
    blog_textareas: {
      create: textAreas,
    },
  }
  try {
    const result = await prisma.blog.create({
      data: dbData,
    })
    res.json(result)
  } catch (err) {
    res.status(500).send(err)
  }
})

// delete a post with given id from slug
app.delete('/post/:id', async (req, res) => {
  const { id } = req.params
  const post = await prisma.post.delete({
    where: {
      id: parseInt(id),
    },
  })
  res.json(post)
})

app.post('/signin', async (req, res) => {
  try {
    console.log(req.body.username)
    console.log(req.body.password)
    let validSignIn = false
    let signInAttemptInfo = ''

    const dbUser = await prisma.user.findUnique({
      where: {
        username: req.body.username,
      },
    })

    if (dbUser) {
      validSignIn = bcrypt.compareSync(req.body.password, dbUser.password)
      console.log('these passwords match? ' + validSignIn)
      if (validSignIn) {
        signInAttemptInfo = 'User Authenticated Successfully.'
        req.session.authenticatedUser = dbUser.id
      } else {
        signInAttemptInfo = 'Password is Incorrect.'
      }
    } else {
      console.log('username invalid')
      signInAttemptInfo = 'Username is Invalid.'
    }

    res.send({
      validSignIn: validSignIn,
      signInAttemptInfo: signInAttemptInfo,
      userId: dbUser ? dbUser.id : false,
      isAdmin: dbUser ? dbUser.isAdmin : false,
      profileImagePath: dbUser ? dbUser.profileImagePath : false,
    })
  } catch (err) {
    res.status(500)
  }
})

app.get('/logout', async (req, res) => {
  req.session.authenticatedUser = undefined
  res.send('logout successful')
})

// return blog with a given slug id
app.get('/blog/:id', async (req, res) => {
  const { id } = req.params
  try {
    const blogData = await prisma.blog.findUnique({
      where: {
        id: parseInt(id),
      },
    })
    const imagePathData = await prisma.blog_imagepaths.findMany({
      where: {
        blogId: parseInt(id),
      },
    })
    const textAreaData = await prisma.blog_textareas.findMany({
      where: {
        blogId: parseInt(id),
      },
    })
    if (blogData) {
      blogData.imagePaths = imagePathData
        ? imagePathData.map((imageDatum) => imageDatum.imagePath)
        : []
      blogData.textAreas = textAreaData
        ? textAreaData.map((textAreaDatum) => textAreaDatum.textArea)
        : []
    }

    res.send(blogData)
  } catch (err) {
    res.status(500).send(err)
  }
})

app.listen(3000, () =>
  console.log('🚀 Server ready at: http://localhost:3000\n')
)

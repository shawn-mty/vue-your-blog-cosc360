const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const { PrismaClient } = require('@prisma/client')
const multer = require('multer')
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

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads/')
  },
  filename: function (req, file, cb) {
    cb(
      null,
      new Date().toISOString().replace(/:/g, '-') + '-' + file.originalname
    )
  },
})

const fileFilter = (req, file, cb) => {
  if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
    cb(null, true)
  } else {
    cb(null, false)
  }
}

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5,
  },
  fileFilter: fileFilter,
})

const prisma = new PrismaClient()
const app = express()

app.use(cors())
app.use(bodyParser.json())
const path = require('path')
app.use(
  '/uploads',
  express.static(path.join(__dirname, '..', 'uploads')),
  serveIndex(path.join(__dirname, '..', 'uploads'))
)

// create user in database and return response
app.post('/create-user', upload.single('image'), async (req, res) => {
  const hashedPass = bcrypt.hashSync(req.body.password, saltRounds)
  const dbData = {
    email: req.body.email,
    username: req.body.username,
    password: hashedPass,
    profileImagePath: req.file.path,
  }
  const result = await prisma.user.create({
    data: dbData,
  })
  res.json(result)
})

// create post in database and return response
app.post('/create-blog', upload.array('images'), async (req, res) => {
  const textAreas = req.body.textAreas
  const images = req.files
  const blogElementTypesOrderString = req.body.blogElementTypesOrder
  const dbData = {
    title: req.body.title,
    orderOfElements: blogElementTypesOrderString,
    user: { connect: { id: 2 } }, // TODO add actual user after login feature built
  }

  if (typeof textAreas === 'string') dbData.textArea0 = textAreas
  else {
    textAreas.forEach((textArea, textAreaIndex) => {
      dbData['textArea' + textAreaIndex] = textArea
    })
  }

  const imagePaths = []
  images.forEach((image, imageIndex) => {
    console.log('image path is ' + image.path)
    imagePaths.push(image.path)
  })
  const stringifiedImagePaths = JSON.stringify(imagePaths)
  console.log(JSON.parse(stringifiedImagePaths))
  dbData.imagePaths = JSON.stringify(imagePaths)

  console.log(dbData)
  const result = await prisma.blog.create({
    data: dbData,
  })
  res.json(result)
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

// return post with a given id from slug
app.get('/blog/:id', async (req, res) => {
  const { id } = req.params
  const blogData = await prisma.blog.findUnique({
    where: {
      id: parseInt(id),
    },
  })
  console.log(blogData)

  res.send(blogData)
})

// display users
// (async function () {
//   const allUsers = await prisma.user.findMany({
//     include: {
//       posts: true,
//       profile: true,
//     },
//   })
//   console.dir(allUsers, { depth: null })
// })();

// post data
// const post = await prisma.post.update({
//   where: { id: 1 },
//   data: { published: true },
// })
// console.log(post)

app.listen(3000, () =>
  console.log('🚀 Server ready at: http://localhost:3000\n')
)

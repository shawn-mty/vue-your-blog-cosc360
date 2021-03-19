const express = require('express');
const bodyParser = require('body-parser');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.json());

// create user in database and return response
app.post('/user', async (req, res) => {
  const result = await prisma.user.create({
    data: {
      // name: 'Alice',
      // email: 'alice@prisma.io',
      // posts: {
      //   create: { title: 'Hello World' },
      // },
      // profile: {
      //   create: { bio: 'I like turtles' },
      // },
      ...req.body,
    },
  });
  res.json(result);
});

// create post in database and return response
app.post('/post', async (req, res) => {
  const { title, content, authorEmail } = req.body;
  const result = await prisma.post.create({
    data: {
      title,
      content,
      published: false,
      author: { connect: { email: authorEmail } },
    },
  });
  res.json(result);
});

// delete a post with given id from slug
app.delete('/post/:id', async (req, res) => {
  const { id } = req.params;
  const post = await prisma.post.delete({
    where: {
      id: parseInt(id),
    },
  });
  res.json(post);
});

// return post with a given id from slug
app.get('/post/:id', async (req, res) => {
  const { id } = req.params;
  const post = await prisma.post.findUnique({
    where: {
      id: parseInt(id),
    },
  });
  res.json(post);
});

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
);

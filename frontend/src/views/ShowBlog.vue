<template>
  <v-container class="blog ">
    <v-row class="d-flex justify-center my-5 mx-3">
      <h1 class="text-center">{{ title }}</h1>
    </v-row>
    <v-row
      v-for="blogElement in blogElements"
      :key="blogElement.index"
      class="d-flex justify-center my-5 mx-3"
    >
      <v-img v-if="blogElement.type === 'image'" :src="blogElement.content" />

      <v-col
        class="d-flex flex-column "
        v-html="blogElement.content"
        v-if="blogElement.type === 'textArea'"
      />
    </v-row>
    <v-divider />
    <v-row class="d-flex mb-5 mt-2 mx-3 ">
      <BlogComments :comments="comments" @updatePage="getBlog()" />
    </v-row>
  </v-container>
</template>

<script>
import EventService from '@/services/EventService.js'
import BlogComments from '../components/BlogComments.vue'
export default {
  methods: {
    getBlog() {
      this.blogElements = []
      EventService.getBlog(this.id) // <--- Send the prop id to our EventService
        .then(response => {
          const blogData = response.data
          this.title = blogData.title
          let imageURLs = []
          blogData.imagePaths.map(imagePath => {
            imageURLs.push(
              'http://localhost:3000/' + imagePath.replace(/\\/g, '/')
            )
          })
          this.comments = blogData.blogComments
          const orderOfElements = JSON.parse(blogData.orderOfElements)
          for (let i = 0; i < orderOfElements.length; i++) {
            if (orderOfElements[i] === 'textArea') {
              this.blogElements.push({
                type: 'textArea',
                content: blogData.textAreas.shift(),
              })
            } else if (orderOfElements[i] === 'image') {
              this.blogElements.push({
                type: 'image',
                content: imageURLs.shift(),
              })
            }
          }
        })
        .catch(error => {
          console.log('There was an error:', error.response)
        })
    },
  },
  components: { BlogComments },
  props: ['id'],
  data() {
    return {
      title: '',
      blogElements: [],
      comments: [],
    }
  },
  created() {
    this.getBlog()
  },
}
</script>

<style>
.blog h2,
.blog h3 {
  text-align: center;
  margin-bottom: 1em;
}
.blog.container {
  max-width: 80ch !important;
}
</style>

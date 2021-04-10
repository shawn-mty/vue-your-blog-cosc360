<template>
  <v-container>
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
    <v-row class="d-flex my-5 mx-3 ">
      <BlogComments />
    </v-row>
  </v-container>
</template>

<script>
import EventService from '@/services/EventService.js'
import BlogComments from '../components/BlogComments.vue'
export default {
  components: { BlogComments },
  props: ['id'],
  data() {
    return {
      title: '',
      blogElements: [],
    }
  },
  created() {
    EventService.getBlog(this.id) // <--- Send the prop id to our EventService
      .then(response => {
        const blogData = response.data
        this.title = blogData.title
        let imageURLs = []
        let textSections = []
        JSON.parse(blogData.imagePaths).map(imagePath => {
          imageURLs.push(
            'http://localhost:3000/' + imagePath.replace(/\\/g, '/')
          )
        })

        for (const property in blogData) {
          if (property.includes('textArea')) {
            // console.log(blogData[property])
            textSections.push(blogData[property])
          }
        }
        const orderOfElements = JSON.parse(blogData.orderOfElements)
        for (let i = 0; i < orderOfElements.length; i++) {
          if (orderOfElements[i] === 'textArea') {
            this.blogElements.push({
              type: 'textArea',
              content: textSections.shift(),
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
}
</script>

<style>
body,
html {
  overflow-wrap: anywhere;
}
h2,
h3 {
  text-align: center;
  margin-bottom: 1em;
}
</style>

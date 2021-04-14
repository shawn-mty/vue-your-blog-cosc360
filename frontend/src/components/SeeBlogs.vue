<template>
  <v-container class="d-flex justify-center   my-5 ">
    <v-row wrap>
      <v-col
        v-for="blog in blogs"
        :key="blog.id"
        sm="4"
        cols="12"
        class="d-flex justify-center"
      >
        <v-card class="mx-auto" width="400" @click="goToBlog(blog.id)">
          <v-img
            class="white--text align-end secondary lighten-4"
            style="text-shadow: 4px 4px 10px black,  4px 4px 10px #1976D2,  4px 4px 10px black;"
            height="200px"
            :src="convertToURL(blog.imagePath)"
          >
            <v-card-title style="word-break:break-word !important;">
              {{ blog.title }}
            </v-card-title>
          </v-img>
          <v-card-text>
            <div>
              {{ blog.textArea }}
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { getBlogs } from '@/services/EventService'

export default {
  data() {
    return {
      blogs: [],
    }
  },
  async created() {
    const blogResponse = await getBlogs()
    this.blogs = blogResponse.data
    console.log(this.blogs)
  },
  methods: {
    goToBlog(id) {
      this.$router.push('blog/' + id)
    },
    convertToURL(imagePath) {
      if (imagePath)
        return 'http://localhost:3000/' + imagePath.replace(/\\/g, '/')
      else ''
    },
  },
}
</script>

<style></style>

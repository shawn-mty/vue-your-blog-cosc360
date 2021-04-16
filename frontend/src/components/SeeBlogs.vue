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
        <v-card style="height:fit-content;" class="mx-auto" width="400">
          <v-img
            @click="goToBlog(blog.id)"
            class="white--text align-end secondary lighten-4"
            style=" cursor:pointer; text-shadow: 4px 4px 10px black,  4px 4px 10px #1976D2,  4px 4px 10px black;"
            height="200px"
            :src="convertToURL(blog.imagePath)"
          >
            <v-card-title style="word-break:break-word !important;">
              {{ blog.title }}
            </v-card-title>
          </v-img>
          <v-card-actions>
            <v-btn color="orange lighten-2" text>
              {{ shortenText(blog.textArea) }}
            </v-btn>

            <v-spacer></v-spacer>

            <v-btn icon @click="blog.show = !blog.show">
              <v-icon>{{
                blog.show ? 'mdi-chevron-up' : 'mdi-chevron-down'
              }}</v-icon>
            </v-btn>
          </v-card-actions>

          <v-expand-transition>
            <div v-show="blog.show">
              <v-divider></v-divider>
              <v-card-text>
                {{ blog.textArea }}
              </v-card-text>
            </div>
          </v-expand-transition>
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
      show: false,
    }
  },
  async created() {
    const blogResponse = await getBlogs()
    this.blogs = blogResponse.data
    this.blogs = this.blogs.map(blog => ({ ...blog, show: false }))
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
    shortenText(text) {
      return text.substring(0, 19) + '...'
    },
  },
}
</script>

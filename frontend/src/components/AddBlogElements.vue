<template>
  <v-speed-dial
    class="ml-auto"
    v-model="fab"
    direction="left"
    open-on-hover
    transition="slide-x-reverse-transition"
  >
    <template v-slot:activator>
      <v-btn v-model="fab" color="green" dark fab>
        <v-icon v-if="fab">
          mdi-close
        </v-icon>
        <v-icon v-else>
          mdi-plus
        </v-icon>
      </v-btn>
    </template>
    <v-btn @click="addBlogElement('image')" fab dark small color="orange">
      <v-icon>mdi-image</v-icon>
    </v-btn>
    <v-btn @click="addBlogElement('textArea')" fab dark small color="blue">
      <v-icon>mdi-text-box</v-icon>
    </v-btn>
  </v-speed-dial>
</template>

<script>
export default {
  props: {
    blogElements: {
      type: Array,
    },
    submitStatus: {
      type: String,
    },
    maxTextAreas: {
      type: Number,
    },
    maxImages: {
      type: Number,
    },
  },
  data() {
    return {
      fab: false,
      uniqueId: -1,
    }
  },
  methods: {
    addBlogElement(blogElementType) {
      if (this.disallowTooManyBlogElements(blogElementType)) return
      this.uniqueId++
      let blogElements = this.blogElements
      blogElements.push({
        type: blogElementType,
        content: null,
        id: this.uniqueId,
      })
      this.$emit('update:blogElements', blogElements)
    },
    disallowTooManyBlogElements(blogElementType) {
      let imageCount = 0
      let textAreaCount = 0
      this.blogElements.forEach(blogElement => {
        if (blogElement.type === 'textArea') textAreaCount++
        else if (blogElement.type === 'image') imageCount++
      })

      if (textAreaCount >= this.maxTextAreas && imageCount >= this.maxImages) {
        this.$emit('update:submitStatus', 'TOOMANYTEXTAREASANDIMAGES')

        return true
      } else if (
        textAreaCount === this.maxTextAreas &&
        blogElementType === 'textArea'
      ) {
        this.$emit('update:submitStatus', 'TOOMANYTEXTAREAS')
        return true
      } else if (imageCount >= this.maxImages && blogElementType === 'image') {
        this.$emit('update:submitStatus', 'TOOMANYIMAGES')
        return true
      } else {
        this.$emit('update:submitStatus', '')
        return false
      }
    },
  },
}
</script>

<style></style>

<template>
  <v-container>
    <v-row>
      <v-col class="justify-center w-50">
        <h1>Make a Blog</h1>
        <v-form>
          <v-text-field
            v-model="title"
            :error-messages="titleErrors"
            :counter="maxCharCount"
            label="Title"
            required
            @input="$v.title.$touch()"
            @blur="$v.title.$touch()"
          >
          </v-text-field>
          <div v-for="blogElement in blogElements" :key="blogElement.id">
            <v-row class="d-flex align-center mx-1 my-1">
              <tiptap-vuetify
                class="d-flex mr-auto"
                style="width: 85%; min-width:85%; max-width:95%; flex: 1 1 auto; "
                :card-props="{ width: '98%' }"
                v-if="blogElement.type == 'textArea'"
                v-model="blogElement.content"
                :extensions="extensions"
                placeholder="Write your blog"
                required
              />

              <v-file-input
                v-if="blogElement.type === 'image'"
                v-model="blogElement.content"
                :rules="imageRules"
                :error-messages="imageErrors(blogElement.id)"
                placeholder="Insert Pic"
                accept="image/png, image/jpeg, image/bmp"
                prepend-icon="mdi-camera"
                label="Insert Pic"
                chips
              />
              <v-btn
                @click="removeBlogElement(blogElement.id)"
                color="red"
                dark
                fab
                x-small
              >
                <v-icon>
                  mdi-close
                </v-icon>
              </v-btn>
            </v-row>
          </div>
          <v-row class="d-flex justify-end my-6 mx-1">
            <v-speed-dial
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
              <v-btn
                @click="addBlogElement('image')"
                fab
                dark
                small
                color="orange"
              >
                <v-icon>mdi-image</v-icon>
              </v-btn>
              <v-btn
                @click="addBlogElement('textArea')"
                fab
                dark
                small
                color="blue"
              >
                <v-icon>mdi-text-box</v-icon>
              </v-btn>
            </v-speed-dial>
          </v-row>

          <v-btn
            class="mr-4 primary"
            @click="submit"
            :disabled="submitStatus === 'PENDING'"
          >
            submit
          </v-btn>
          <v-btn @click="clear">
            clear
          </v-btn>
          <div class="mt-5"></div>
          <p class="typo__p" v-if="submitStatus === 'OK'">
            Thanks for your submission!
          </p>
          <p class="typo__p" v-if="submitStatus === 'ERROR'">
            Please fill the blog form correctly.
          </p>
          <p class="typo__p" v-if="submitStatus === 'PENDING'">Sending...</p>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { required, maxLength, minLength } from 'vuelidate/lib/validators'
// import EventService from '@/services/EventService'
import {
  TiptapVuetify,
  Heading,
  Bold,
  Italic,
  Strike,
  Underline,
  Code,
  Paragraph,
  BulletList,
  OrderedList,
  ListItem,
  Link,
  Blockquote,
  HardBreak,
  History,
} from 'tiptap-vuetify'

export default {
  mixins: [validationMixin],
  validations: {
    title: { required, maxLength: maxLength(14), minLength: minLength(4) },
    blogElements: {
      $each: {
        content: {
          required,
          maxLength: maxLength(128),
          minLength: minLength(4),
        },
      },
    },
    textArea: {
      required,
      maxLength: maxLength(2096),
      minLength: minLength(255),
    },
    image: { required },
  },
  components: { TiptapVuetify },
  data: () => ({
    title: '',
    textArea: '',
    uniqueId: -1,
    blogElements: [],
    image: null,
    minCharCount: 4,
    maxCharCount: 14,
    maxTextAreaCharCount: 4096,
    submitStatus: null,
    imageRules: [
      value =>
        !value ||
        value.size < 4000000 ||
        'Avatar size should be less than 4 MB!',
    ],
    fab: false,
    extensions: [
      History,
      Blockquote,
      Link,
      Underline,
      Strike,
      Italic,
      ListItem,
      BulletList,
      OrderedList,
      [
        Heading,
        {
          options: {
            levels: [1, 2, 3],
          },
        },
      ],
      Bold,
      Code,
      Paragraph,
      HardBreak,
    ],
  }),

  computed: {
    titleErrors() {
      const errors = []
      if (!this.$v.title.$dirty) return errors
      !this.$v.title.maxLength &&
        errors.push(
          'Title must be at most ' + this.maxCharCount + ' characters long'
        )
      !this.$v.title.minLength &&
        errors.push(
          'Title must be at least ' + this.minCharCount + ' characters long'
        )
      !this.$v.title.required && errors.push('Title is required.')
      return errors
    },
  },

  methods: {
    addBlogElement(blogElementType) {
      this.uniqueId++
      this.blogElements.push({
        type: blogElementType,
        content: null,
        id: this.uniqueId,
      })
    },

    textAreaErrors(blogElementId) {
      let blogElementIndex = this.blogElements.findIndex(blogElement => {
        return blogElement.id === blogElementId
      })
      const errors = []
      if (!this.$v.blogElements.$each[blogElementIndex].content.$dirty)
        return errors
      !this.$v.blogElements.$each[blogElementIndex].content.maxLength &&
        errors.push(
          'Text Area must be at most ' +
            this.maxTextAreaCharCount +
            ' characters long'
        )
      !this.$v.blogElements.$each[blogElementIndex].content.minLength &&
        errors.push(
          'Text Area must be at least ' + this.minCharCount + ' characters long'
        )
      !this.$v.blogElements.$each[blogElementIndex].content.required &&
        errors.push('TextArea is required.')
      return errors
    },

    imageErrors(blogElementId) {
      let blogElementIndex = this.blogElements.findIndex(blogElement => {
        return blogElement.id === blogElementId
      })

      const errors = []
      if (!this.$v.blogElements.$each[blogElementIndex].content.$dirty)
        return errors

      !this.$v.blogElements.$each[blogElementIndex].content.required &&
        errors.push('Pic is required.')

      return errors
    },
    removeBlogElement(blogElementId) {
      let blogElementIndex = this.blogElements.findIndex(
        blogElement => blogElement.id === blogElementId
      )

      this.blogElements.splice(blogElementIndex, 1)
    },
    submit() {
      // var bodyFormData = new FormData()
      // bodyFormData.append('title', this.title)
      // bodyFormData.append('body', this.body)
      // bodyFormData.append('image', this.image)
      this.$v.$touch()
      // if (this.$v.$invalid) {
      //   this.submitStatus = 'ERROR'
      // } else {
      //   // do your submit logic here
      //   this.submitStatus = 'PENDING'
      //   EventService.createUser(bodyFormData)
      //     .then(response => {
      //       console.log(response)
      //       this.submitStatus = 'OK'
      //     })
      //     .then(() => {
      //       this.$router.push('/')
      //     })
      // }
    },
    clear() {
      this.$v.$reset()
      this.title = ''
      this.body = ''
    },
  },
}
</script>

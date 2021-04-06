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
            <v-row class="d-flex align-center mx-1">
              <v-text-field
                class="mr-2"
                v-if="blogElement.type == 'header'"
                v-model="blogElement.content"
                :error-messages="headerErrors"
                :counter="maxHeaderCharCount"
                label="Header"
                required
                @input="$v.header.$touch()"
                @blur="$v.header.$touch()"
              >
              </v-text-field>
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
            <v-textarea
              v-if="blogElement.type == 'textArea'"
              v-model="body"
              :error-messages="textAreaErrors"
              :counter="maxCharCount"
              label="Body"
              type="body"
              required
              @input="$v.body.$touch()"
              @blur="$v.body.$touch()"
            ></v-textarea>

            <v-file-input
              v-if="blogElement.type === 'image'"
              v-model="image"
              :rules="imageRules"
              :error-messages="imageErrors"
              placeholder="Insert Pic"
              accept="image/png, image/jpeg, image/bmp"
              prepend-icon="mdi-camera"
              label="Insert Profile Pic"
              chips
            ></v-file-input>
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
              <v-btn fab dark small color="orange">
                <v-icon>mdi-image</v-icon>
              </v-btn>
              <v-btn fab dark small color="blue">
                <v-icon>mdi-text-box</v-icon>
              </v-btn>
              <v-btn
                @click="addBlogElement('header')"
                fab
                dark
                small
                color="indigo"
              >
                <v-icon>mdi-subtitles</v-icon>
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
import EventService from '@/services/EventService'
// import the component and the necessary extensions

export default {
  mixins: [validationMixin],
  validations: {
    title: { required, maxLength: maxLength(14), minLength: minLength(4) },
    header: { required, maxLength: maxLength(128), minLength: minLength(4) },
    body: { required, maxLength: maxLength(2096), minLength: minLength(255) },
    image: { required },
  },

  data: () => ({
    title: '',
    body: '',
    uniqueId: 0,
    blogElements: [],
    image: null,
    minCharCount: 4,
    maxCharCount: 14,
    maxHeaderCharCount: 128,
    submitStatus: null,
    imageRules: [
      value =>
        !value ||
        value.size < 4000000 ||
        'Avatar size should be less than 4 MB!',
    ],
    direction: 'top',
    fab: false,
    fling: false,
    tabs: null,
  }),

  computed: {
    activeFab() {
      switch (this.tabs) {
        case 'one':
          return { class: 'purple', icon: 'account_circle' }
        case 'two':
          return { class: 'red', icon: 'edit' }
        case 'three':
          return { class: 'green', icon: 'keyboard_arrow_up' }
        default:
          return {}
      }
    },

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
    headerErrors() {
      const errors = []
      if (!this.$v.header.$dirty) return errors
      !this.$v.header.maxLength &&
        errors.push(
          'Header must be at most ' +
            this.maxHeaderCharCount +
            ' characters long'
        )
      !this.$v.header.minLength &&
        errors.push(
          'Header must be at least ' + this.minCharCount + ' characters long'
        )
      !this.$v.header.required && errors.push('Title is required.')
      return errors
    },

    imageErrors() {
      const errors = []
      if (!this.$v.image.$dirty) return errors
      !this.$v.image.required && errors.push('Profile Pic is required')
      return errors
    },
  },

  methods: {
    addBlogElement(blogElementType) {
      this.blogElements.push({
        type: blogElementType,
        content: null,
        id: this.uniqueId,
      })
      this.uniqueId++
    },
    removeBlogElement(blogElementId) {
      let blogElementIndex = this.blogElements.findIndex(
        blogElement => blogElement.id === blogElementId
      )

      this.blogElements.splice(blogElementIndex, 1)
    },
    submit() {
      var bodyFormData = new FormData()
      bodyFormData.append('title', this.title)
      bodyFormData.append('body', this.body)
      bodyFormData.append('image', this.image)
      this.$v.$touch()
      if (this.$v.$invalid) {
        this.submitStatus = 'ERROR'
      } else {
        // do your submit logic here
        this.submitStatus = 'PENDING'
        EventService.createUser(bodyFormData)
          .then(response => {
            console.log(response)
            this.submitStatus = 'OK'
          })
          .then(() => {
            this.$router.push('/')
          })
      }
    },
    clear() {
      this.$v.$reset()
      this.title = ''
      this.body = ''
      this.checkbox = false
    },
  },
  watch: {
    top(val) {
      this.bottom = !val
    },
    right(val) {
      this.left = !val
    },
    bottom(val) {
      this.top = !val
    },
    left(val) {
      this.right = !val
    },
  },
}
</script>

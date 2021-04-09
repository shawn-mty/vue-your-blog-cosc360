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
            <v-row class="d-flex align-center mx-1 mt-1 mb-0">
              <tiptap-vuetify
                class="d-flex mr-auto"
                style="width: 85%; min-width:85%; max-width:95%; flex: 1 1 auto; "
                :card-props="{ width: '98%' }"
                v-if="blogElement.type == 'textArea'"
                v-model="blogElement.content"
                @blur="
                  blogElement.content &&
                  blogElement.content.length < 10 &&
                  blogElement.content.includes('<')
                    ? (blogElement.content = null)
                    : true
                "
                :extensions="extensions"
                placeholder="Write a section of your blog here"
                required
              />

              <v-file-input
                v-if="blogElement.type === 'image'"
                v-model="blogElement.content"
                class="d-flex mr-auto"
                style=" max-width:93%;"
                :rules="imageRules"
                :error-messages="imageErrors(blogElement.id)"
                placeholder="Insert Pic"
                accept="image/png, image/jpeg, image/bmp"
                prepend-icon="mdi-camera"
                label="Insert Pic"
                chips
              />
              <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
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
            <v-row
              v-if="blogElement.type === 'textArea'"
              class="d-flex align-center mx-1 mt-0 mb-0"
            >
              <v-text-field
                class="d-flex mr-auto pt-0 mt-0"
                hidden
                style=" min-width:85%; max-width:93%; flex: 1 1 auto; "
                v-model="blogElement.content"
                :error-messages="textAreaErrors(blogElement.id)"
              />
              <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
              <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
              <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
            </v-row>
          </div>
          <v-row class="d-flex justify-space-between my-6 mx-1">
            <v-row
              class="d-flex align-center mx-1 mb-0"
              v-if="submitStatus === 'TOOMANYTEXTAREAS'"
            >
              <p class="error--text mb-0 mr-2">
                Max number of Blog
                <br class="d-sm-none d-md-none d-lg-none d-xl-none" />
                Text Sections is 4
              </p>
              <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
              <v-btn @click="submitStatus = ''" class="info">Okay</v-btn>
            </v-row>
            <v-row
              class="d-flex align-center mx-1 mb-0"
              v-if="submitStatus === 'TOOMANYIMAGES'"
            >
              <p class="error--text mb-0 mr-2">
                Max number of Images is 6
              </p>
              <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
              <v-btn @click="submitStatus = ''" class="info">
                Okay
              </v-btn>
            </v-row>
            <v-row
              class="d-flex align-center mx-1 mb-0"
              v-if="submitStatus === 'TOOMANYTEXTAREASANDIMAGES'"
            >
              <p class="error--text mb-0 mr-2">
                Max number of Images is 6 <br />
                Max number of Blog Text Sections is 4
              </p>
              <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
              <v-btn @click="submitStatus = ''" class="info">
                Okay
              </v-btn>
            </v-row>
            <v-row
              class="d-flex align-center mx-1 mb-0"
              v-if="submitStatus === 'NOTEXTAREAS'"
            >
              <p class="error--text mb-0 mr-2 ">
                Must have at least one<br
                  class="d-sm-none d-md-none d-lg-none d-xl-none"
                />
                Blog Text Section to submit
              </p>
              <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
              <v-btn @click="submitStatus = ''" class="info  my-4">
                Okay
              </v-btn>
            </v-row>

            <v-spacer v-else />
            <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
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
          <p class="typo__p success--text" v-if="submitStatus === 'OK'">
            Thanks for your submission!
          </p>
          <p class="typo__p error--text" v-if="submitStatus === 'ERROR'">
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
    title: { required, maxLength: maxLength(127), minLength: minLength(4) },
    blogElements: {
      $each: {
        content: {
          required,
          maxLength: maxLength(2047),
        },
      },
    },
  },
  components: { TiptapVuetify },
  data: () => ({
    title: '',
    uniqueId: -1,
    blogElements: [],
    minCharCount: 4,
    maxCharCount: 127,
    maxTextAreaCharCount: 2047,
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
    disallowTooManyBlogElements(blogElementType) {
      let imageCount = 0
      let textAreaCount = 0
      this.blogElements.forEach(blogElement => {
        if (blogElement.type === 'textArea') textAreaCount++
        else if (blogElement.type === 'image') imageCount++
      })

      if (textAreaCount >= 4 && imageCount >= 6) {
        this.submitStatus = 'TOOMANYTEXTAREASANDIMAGES'
        return true
      } else if (textAreaCount === 4 && blogElementType === 'textArea') {
        this.submitStatus = 'TOOMANYTEXTAREAS'
        return true
      } else if (imageCount >= 6 && blogElementType === 'image') {
        this.submitStatus = 'TOOMANYIMAGES'
        return true
      } else {
        this.submitStatus = ''
        return false
      }
    },
    addBlogElement(blogElementType) {
      if (this.disallowTooManyBlogElements(blogElementType)) return
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
          'Blog Section must be at most ' +
            this.maxTextAreaCharCount +
            ' characters long'
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
      this.submitStatus = ''
      let blogElementIndex = this.blogElements.findIndex(
        blogElement => blogElement.id === blogElementId
      )

      this.blogElements.splice(blogElementIndex, 1)
    },

    submit() {
      this.$v.$touch()
      let textAreaCount = 0
      this.blogElements.forEach(blogElement => {
        if (blogElement.type === 'textArea') textAreaCount++
      })
      if (textAreaCount === 0) {
        this.submitStatus = 'NOTEXTAREAS'
        return
      }
      if (this.$v.$invalid) {
        this.submitStatus = 'ERROR'
      } else {
        this.submitStatus = 'PENDING'
        let bodyFormData = new FormData()
        bodyFormData.append('title', this.title)

        let blogElementTypesOrder = []
        this.blogElements.forEach(blogElement => {
          if (blogElement.type === 'textArea') {
            bodyFormData.append('textAreas', blogElement.content)
            console.log(blogElement.type)
            blogElementTypesOrder.push(blogElement.type)
          } else if (blogElement.type === 'image') {
            bodyFormData.append('images', blogElement.content)
            blogElementTypesOrder.push(blogElement.type)
          }
        })
        bodyFormData.append(
          'blogElementTypesOrder',
          JSON.stringify(blogElementTypesOrder)
        )

        EventService.createBlog(bodyFormData)
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
      this.submitStatus = ''
      this.$v.$reset()
      this.title = ''
      this.blogElements.forEach(blogElement => {
        blogElement.content = null
      })
    },
  },
}
</script>

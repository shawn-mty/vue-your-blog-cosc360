<template>
  <v-container>
    <v-row>
      <v-col class="justify-center w-50">
        <h1>Make a Blog</h1>
        <v-form>
          <BlogTitle :title.sync="title" />
          <div
            v-for="(blogElement, index) in blogElements"
            :key="blogElement.id"
          >
            <v-row class="d-flex align-center mx-1 mt-1 mb-0">
              <BlogTextArea
                class="mt-4"
                :blogElements="blogElements"
                :blogElementIndex="index"
                :textAreaErrors="textAreaErrors(blogElement.id)"
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
            <BlogTextAreaValidation
              :blogElement="blogElement"
              :textAreaErrors="textAreaErrors(blogElement.id)"
            />
          </div>
          <v-row class="d-flex justify-space-between my-6 mx-1">
            <BlogFormSubmitErrors
              :submitStatus.sync="submitStatus"
              :maxTextAreas="maxTextAreas"
              :maxImages="maxImages"
            />
            <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
            <AddBlogElements
              :blogElements.sync="blogElements"
              :submitStatus.sync="submitStatus"
              :maxTextAreas="maxTextAreas"
              :maxImages="maxImages"
            />
          </v-row>
          <FormSubmitAndClear
            :submitStatus.sync="submitStatus"
            @clear="clear"
            @submit="submit"
          />
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { required, maxLength, minLength } from 'vuelidate/lib/validators'
import EventService from '@/services/EventService'
import BlogTitle from '@/components/BlogTitle'
import AddBlogElements from './AddBlogElements.vue'
import BlogTextArea from './BlogTextArea.vue'
import BlogTextAreaValidation from './BlogTextAreaValidation.vue'
import BlogFormSubmitErrors from './BlogFormSubmitErrors.vue'
import FormSubmitAndClear from './FormSubmitAndClear.vue'
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({ currentUser: 'getCurrentUserData' }),
  },
  components: {
    BlogTitle,
    AddBlogElements,
    BlogTextArea,
    BlogTextAreaValidation,
    BlogFormSubmitErrors,
    FormSubmitAndClear,
  },
  data: () => ({
    title: '',
    blogElements: [],
    maxTextAreaCharCount: 2047,
    maxTextAreas: 10,
    maxImages: 15,
    submitStatus: null,
    imageRules: [
      value =>
        !value ||
        value.size < 4000000 ||
        'Avatar size should be less than 4 MB!',
    ],
  }),

  methods: {
    getBlogElementIndex(blogElementId) {
      return this.blogElements.findIndex(blogElement => {
        return blogElement.id === blogElementId
      })
    },
    textAreaErrors(blogElementId) {
      let blogElementIndex = this.getBlogElementIndex(blogElementId)
      const domBlogElement = this.$v.blogElements.$each[blogElementIndex]

      const errors = []
      if (!domBlogElement.content.$dirty) return errors
      !domBlogElement.content.maxLength &&
        errors.push(
          'Blog Text Section must be at most ' +
            this.maxTextAreaCharCount +
            ' characters long'
        )
      !domBlogElement.content.required && errors.push('TextArea is required.')

      return errors
    },
    imageErrors(blogElementId) {
      let blogElementIndex = this.getBlogElementIndex(blogElementId)
      const domBlogElement = this.$v.blogElements.$each[blogElementIndex]

      const errors = []
      if (!domBlogElement.content.$dirty) return errors
      !domBlogElement.content.required && errors.push('Pic is required.')

      return errors
    },
    removeBlogElement(blogElementId) {
      this.submitStatus = ''
      let blogElementIndex = this.getBlogElementIndex(blogElementId)

      this.blogElements.splice(blogElementIndex, 1)
    },

    submit() {
      this.$v.$touch()
      let textAreaCount = 0
      let imageCount = 0
      this.blogElements.forEach(blogElement => {
        if (blogElement.type === 'textArea') textAreaCount++
        if (blogElement.type === 'image') imageCount++
      })

      if (textAreaCount === 0 && imageCount === 0) {
        this.submitStatus = 'NOTEXTAREASORIMAGES'
        return
      } else if (textAreaCount === 0) {
        this.submitStatus = 'NOTEXTAREAS'
        return
      } else if (imageCount === 0) {
        this.submitStatus = 'NOIMAGES'
        return
      }
      if (this.$v.$invalid) {
        this.submitStatus = 'ERROR'
      } else {
        this.submitStatus = 'PENDING'
        let bodyFormData = new FormData()
        bodyFormData.append('title', this.title)
        bodyFormData.append('username', this.currentUser.username)

        let blogElementTypesOrder = []
        this.blogElements.forEach(blogElement => {
          if (blogElement.type === 'textArea') {
            bodyFormData.append('textAreas', blogElement.content)
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
            this.submitStatus = 'OK'
            this.$router.push('blog/' + response.data.id) // TODO go to dynamic blog pages
          })
          .catch(error => {
            console.log('There was an error:', error.response)
          })
      }
    },
    clear() {
      this.submitStatus = ''
      this.title = ''
      this.blogElements = []
      this.$v.$reset()
    },
  },
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
}
</script>

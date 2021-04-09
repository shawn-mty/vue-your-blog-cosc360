<template>
  <v-container>
    <v-row>
      <v-col class="justify-center w-50">
        <h1>Register</h1>

        <v-form>
          <v-text-field
            v-model="username"
            :error-messages="usernameErrors"
            :counter="maxCharCount"
            label="Username"
            required
            @input="$v.username.$touch()"
            @blur="$v.username.$touch()"
          ></v-text-field>
          <v-text-field
            v-model="password"
            :error-messages="passwordErrors"
            :counter="maxCharCount"
            label="Password"
            type="password"
            required
            @input="$v.password.$touch()"
            @blur="$v.password.$touch()"
          ></v-text-field>
          <v-text-field
            v-model="email"
            :error-messages="emailErrors"
            label="E-mail"
            required
            @input="$v.email.$touch()"
            @blur="$v.email.$touch()"
          ></v-text-field>
          <v-row>
            <v-file-input
              class="mt-3 ml-2"
              v-model="image"
              :rules="imageRules"
              :error-messages="imageErrors"
              placeholder="Insert Profile Pic"
              accept="image/png, image/jpeg, image/bmp"
              prepend-icon="mdi-camera"
              label="Insert Profile Pic"
              chips
            ></v-file-input>
            <v-spacer />
          </v-row>

          <v-checkbox
            v-model="checkbox"
            :error-messages="checkboxErrors"
            label="Do you agree to let us do whatever we want with your data?"
            required
            @change="$v.checkbox.$touch()"
            @blur="$v.checkbox.$touch()"
          ></v-checkbox>

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
            Please fill the form correctly.
          </p>
          <p class="typo__p" v-if="submitStatus === 'PENDING'">Sending...</p>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { required, maxLength, minLength, email } from 'vuelidate/lib/validators'
import EventService from '@/services/EventService'

export default {
  mixins: [validationMixin],

  validations: {
    username: { required, maxLength: maxLength(14), minLength: minLength(4) },
    password: { required, maxLength: maxLength(14), minLength: minLength(4) },
    email: { required, email },
    image: { required },
    checkbox: {
      checked(val) {
        return val
      },
    },
  },

  data: () => ({
    username: '',
    password: '',
    email: '',
    image: null,
    checkbox: false,
    minCharCount: 4,
    maxCharCount: 14,
    submitStatus: null,
    imageRules: [
      value =>
        !value ||
        value.size < 4000000 ||
        'Avatar size should be less than 4 MB!',
    ],
  }),

  computed: {
    checkboxErrors() {
      const errors = []
      if (!this.$v.checkbox.$dirty) return errors
      !this.$v.checkbox.checked && errors.push('You must agree to continue!')
      return errors
    },
    usernameErrors() {
      const errors = []
      if (!this.$v.username.$dirty) return errors
      !this.$v.username.maxLength &&
        errors.push(
          'Username must be at most ' + this.maxCharCount + ' characters long'
        )
      !this.$v.username.minLength &&
        errors.push(
          'Username must be at least ' + this.minCharCount + ' characters long'
        )
      !this.$v.username.required && errors.push('Username is required.')
      return errors
    },
    passwordErrors() {
      const errors = []
      if (!this.$v.password.$dirty) return errors
      !this.$v.password.maxLength &&
        errors.push(
          'Password must be at most ' + this.maxCharCount + ' characters long'
        )
      !this.$v.password.minLength &&
        errors.push(
          'Password must be at least ' + this.minCharCount + ' characters long'
        )
      !this.$v.password.required && errors.push('Password is required.')

      if (this.password.includes(this.username))
        errors.push('Username must not include password')

      return errors
    },
    emailErrors() {
      const errors = []
      if (!this.$v.email.$dirty) return errors
      !this.$v.email.email && errors.push('Must be valid e-mail')
      !this.$v.email.required && errors.push('E-mail is required')
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
    submit() {
      this.$v.$touch()
      if (this.$v.$invalid) {
        this.submitStatus = 'ERROR'
      } else {
        // do your submit logic here
        this.submitStatus = 'PENDING'
        var bodyFormData = new FormData()
        bodyFormData.append('username', this.username)
        bodyFormData.append('password', this.password)
        bodyFormData.append('email', this.email)
        bodyFormData.append('image', this.image)
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
      this.username = ''
      this.password = ''
      this.email = ''
      this.checkbox = false
    },
  },
}
</script>

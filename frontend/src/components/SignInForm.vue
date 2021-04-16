<template>
  <v-container>
    <v-row class=" justify-center d-flex">
      <v-col>
        <v-spacer />

        <v-form class="mx-auto" style="max-width: 600px;">
          <h1>Sign In</h1>
          <v-text-field
            autofocus
            v-model="username"
            :error-messages="usernameErrors"
            :counter="maxCharCount"
            label="Username"
            required
            @input="$v.username.$touch()"
            @blur="$v.username.$touch()"
            width="500"
          ></v-text-field>

          <v-text-field
            v-model="password"
            :error-messages="passwordErrors"
            :counter="maxCharCount"
            class="mb-2"
            label="Password"
            type="password"
            required
            @input="$v.password.$touch()"
            @blur="$v.password.$touch()"
            @keyup.enter="submit"
          ></v-text-field>
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
          <p class="typo__p error--text" v-if="submitStatus === 'ERROR'">
            Please fill the form correctly.
          </p>
          <p class="typo__p" v-if="submitStatus === 'PENDING'">Sending...</p>
          <p class="typo__p error--text" v-if="submitStatus === 'BADLOGIN'">
            {{ loginError }}
          </p>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { required, maxLength, minLength } from 'vuelidate/lib/validators'
import EventService from '@/services/EventService'

export default {
  mixins: [validationMixin],

  validations: {
    username: { required, maxLength: maxLength(14), minLength: minLength(4) },
    password: { required, maxLength: maxLength(14), minLength: minLength(4) },
  },

  data: () => ({
    username: '',
    password: '',
    minCharCount: 4,
    maxCharCount: 14,
    submitStatus: null,
    isSignedIn: false,
    loginError: '',
  }),

  computed: {
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
  },

  methods: {
    submit() {
      this.$v.$touch()
      if (this.$v.$invalid) {
        this.submitStatus = 'ERROR'
      } else {
        // do your submit logic here
        this.submitStatus = 'PENDING'
        EventService.checkCredentials({
          username: this.username,
          password: this.password,
        })
          .then(response => {
            if (response.data.validSignIn) {
              this.submitStatus = 'OK'
              this.isSignedIn = true
            } else {
              this.loginError = response.data.signInAttemptInfo
              this.submitStatus = 'BADLOGIN'
              this.isSignedIn = false
            }
            if (this.isSignedIn === true) {
              this.$emit('isSignedIn', this.isSignedIn)
              this.$store.commit('setCurrentUser', {
                id: response.data.userId,
                username: this.username,
                isSignedIn: this.isSignedIn,
                profileImagePath: response.data.profileImagePath.replace(
                  /\\/g,
                  '/'
                ),
              })
              this.$forceUpdate()
              this.$router.push('/')
            }
          })
          .catch(err => {
            alert(err)
          })
      }
    },
    clear() {
      this.$v.$reset()
      this.username = ''
      this.password = ''
    },
  },
}
</script>

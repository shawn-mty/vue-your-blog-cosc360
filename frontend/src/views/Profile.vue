<template>
  <v-container class="my-5" v-if="profile.isSignedIn">
    <v-row class="align-center justify-center d-flex">
      <v-col class="d-flex justify-start" style="max-width:fit-content; ">
        <v-avatar class="mx-4 " size="150">
          <img :src="'http://localhost:3000/' + profile.profileImagePath" />
        </v-avatar>
      </v-col>
      <v-col style="max-width:fit-content;">
        <v-row>
          <v-col class="d-flex justify-center pb-1">
            <h2 class="mx-4 ">{{ profile.username }}</h2>
          </v-col>
        </v-row>
        <v-row>
          <v-col class="d-flex justify-center pt-1">
            <h6 class="mx-4 grey--text darken-5 ">
              {{ profile.email }}
            </h6>
          </v-col>
        </v-row>
        <v-row>
          <v-col class="d-flex justify-center pt-1 ">
            <v-btn
              @click="editing = !editing"
              :color="editing ? '' : 'primary'"
              small
              class="mx-4"
              >Edit Profile
              <v-icon class="ml-2" small> mdi-pencil</v-icon></v-btn
            >
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-form v-show="editing" class=" mx-auto mt-5 " style="max-width: 300px;">
      <v-row class="d-flex justify-center my-5" v-if="!showImageChange">
        <v-btn
          class="secondary"
          @click="showImageChange = !showImageChange"
          width="300"
          >change image
          <v-icon class="ml-2" small> mdi-autorenew</v-icon></v-btn
        >
      </v-row>
      <v-file-input
        v-if="showImageChange"
        class="mt-3 ml-2"
        v-model="newImage"
        :rules="imageRules"
        placeholder="Insert New Profile Pic"
        accept="image/png, image/jpeg, image/bmp"
        prepend-icon="mdi-camera"
        label="Insert Profile Pic"
        chips
      ></v-file-input>
      <v-row class="d-flex justify-center my-5" v-if="!showUsernameChange">
        <v-btn
          class="secondary"
          @click="showUsernameChange = !showUsernameChange"
          width="300"
          >change username
          <v-icon class="ml-2" small> mdi-autorenew</v-icon></v-btn
        >
      </v-row>
      <v-text-field
        v-if="showUsernameChange"
        autofocus
        v-model="newUsername"
        :error-messages="showUsernameChange ? usernameErrors : ''"
        :counter="maxCharCount"
        label="New Username"
        @input="showUsernameChange ? $v.newUsername.$touch() : ''"
        @blur="showUsernameChange ? $v.newUsername.$touch() : ''"
      ></v-text-field>
      <v-row v-if="!showEmailChange" class="d-flex justify-center my-5">
        <v-btn
          class="secondary"
          @click="showEmailChange = !showEmailChange"
          width="300"
          >change email<v-icon class="ml-2" small> mdi-autorenew</v-icon></v-btn
        >
      </v-row>
      <v-text-field
        v-if="showEmailChange"
        v-model="newEmail"
        :error-messages="emailErrors"
        label="New E-mail"
        @input="$v.newEmail.$touch()"
        @blur="$v.newEmail.$touch()"
      ></v-text-field>
      <v-row v-if="!showPasswordChange" class="d-flex justify-center my-5">
        <v-btn
          class="secondary"
          @click="showPasswordChange = !showPasswordChange"
          width="300"
          >change password<v-icon class="ml-2" small>
            mdi-autorenew</v-icon
          ></v-btn
        >
      </v-row>
      <v-text-field
        v-if="showPasswordChange"
        v-model="oldPassword"
        :error-messages="showPasswordChange ? oldPasswordErrors : null"
        :counter="maxCharCount"
        class="mb-2"
        label="Current Password"
        type="password"
        @input="showPasswordChange ? $v.oldPassword.$touch() : ''"
        @blur="showPasswordChange ? $v.oldPassword.$touch() : ''"
        @keyup.enter="submit"
      ></v-text-field>
      <v-text-field
        v-if="showPasswordChange"
        v-model="newPassword"
        :error-messages="showPasswordChange ? newPasswordErrors : ''"
        :counter="maxCharCount"
        class="mb-2"
        label="New Password"
        type="password"
        @input="showPasswordChange ? $v.newPassword.$touch() : ''"
        @blur="showPasswordChange ? $v.newPassword.$touch() : ''"
        @keyup.enter="submit"
      ></v-text-field>
      <div class="d-flex justify-space-between ">
        <div></div>
        <p
          class="typo__p  my-auto success--text font-weight-bold"
          v-if="submitStatus === 'OK'"
        >
          Updated!
        </p>
        <p class="typo__p error--text my-auto" v-if="submitStatus === 'ERROR'">
          Fill in fields.
        </p>
        <p class="typo__p  my-auto" v-if="submitStatus === 'PENDING'">
          Sending...
        </p>

        <v-btn
          class="mr-0 primary"
          @click="submit"
          :disabled="submitStatus === 'PENDING'"
        >
          update
        </v-btn>
      </div>
    </v-form>
  </v-container>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { maxLength, minLength, email } from 'vuelidate/lib/validators'
import { mapGetters } from 'vuex'
import { editProfile } from '@/services/EventService'

export default {
  mixins: [validationMixin],
  validations: {
    newUsername: {
      maxLength: maxLength(14),
      minLength: minLength(4),
    },
    oldPassword: {
      maxLength: maxLength(14),
      minLength: minLength(4),
    },
    newPassword: {
      maxLength: maxLength(14),
      minLength: minLength(4),
    },
    newEmail: {
      email,
    },
  },
  data() {
    return {
      editing: false,
      showUsernameChange: false,
      showEmailChange: false,
      showPasswordChange: false,
      showImageChange: false,
      imageRules: [
        value =>
          !value ||
          value.size < 4000000 ||
          'Avatar size should be less than 4 MB!',
      ],
      newUsername: '',
      newEmail: '',
      oldPassword: '',
      newPassword: '',
      minCharCount: 4,
      maxCharCount: 14,
      submitStatus: null,
      newImage: null,
    }
  },
  computed: {
    ...mapGetters({ profile: 'getCurrentUserData' }),
    emailErrors() {
      const errors = []
      if (!this.$v.newEmail.$dirty) return errors
      !this.$v.newEmail.email && errors.push('Must be valid e-mail.')
      return errors
    },

    usernameErrors() {
      const errors = []
      if (!this.$v.newUsername.$dirty) return errors
      !this.$v.newUsername.maxLength &&
        errors.push(
          'Username must be at most ' + this.maxCharCount + ' characters long'
        )
      !this.$v.newUsername.minLength &&
        errors.push(
          'Username must be at least ' + this.minCharCount + ' characters long'
        )
      return errors
    },
    oldPasswordErrors() {
      return this.oldAndNewPasswordChecker('old')
    },
    newPasswordErrors() {
      return this.oldAndNewPasswordChecker('new')
    },
  },
  mounted() {},
  methods: {
    async submit() {
      if (
        (this.showUsernameChange && !this.newUsername) ||
        (this.showEmailChange && !this.newEmail) ||
        (this.showPasswordChange && (!this.oldPassword || !this.newPassword)) ||
        (this.showImageChange && !this.newImage) ||
        this.$v.$invalid ||
        (!this.showUsernameChange &&
          !this.showEmailChange &&
          !this.showPasswordChange &&
          !this.showImageChange)
      )
        this.submitStatus = 'ERROR'
      else {
        this.submitStatus = 'PENDING'

        let profileFormData = new FormData()
        profileFormData.append('newImage', this.newImage)
        profileFormData.append('newUsername', this.newUsername)
        profileFormData.append('newPassword', this.newPassword)
        profileFormData.append('newEmail', this.newEmail)
        profileFormData.append('oldEmail', this.profile.email)
        profileFormData.append('oldUsername', this.profile.username)
        profileFormData.append('oldPassword', this.oldPassword)
        try {
          const profileEdited = await editProfile(profileFormData)

          this.$store.commit('setCurrentUser', {
            email: profileEdited.data.email,
            id: profileEdited.data.id,
            username: profileEdited.data.username,
            isSignedIn: true,
            profileImagePath: profileEdited.data.profileImagePath.replace(
              /\\/g,
              '/'
            ),
            isAdmin: profileEdited.data.isAdmin,
          })
          this.submitStatus = 'OK'
          setTimeout(() => {
            this.$router.push('/')
          }, 2000)
        } catch (error) {
          console.log(error)
        }
      }
    },
    oldAndNewPasswordChecker(passwordType) {
      const errors = []
      let password = ''
      if (passwordType === 'old') {
        password = this.$v.oldPassword
      } else if (passwordType === 'new') {
        password = this.$v.newPassword
      }

      if (!password.$dirty) return errors
      !password.maxLength &&
        errors.push(
          'Password must be at most ' + this.maxCharCount + ' characters long'
        )
      !password.minLength &&
        errors.push(
          'Password must be at least ' + this.minCharCount + ' characters long'
        )

      if (passwordType === 'new') {
        if (
          (this.newPassword.includes(this.newUsername) && this.newUsername) ||
          this.newPassword.includes(this.profile.username)
        )
          errors.push('Password must not include username')
        if (this.newPassword === this.oldPassword)
          errors.push('New password must be different from Old password')
      }
      return errors
    },
  },
}
</script>

<style></style>

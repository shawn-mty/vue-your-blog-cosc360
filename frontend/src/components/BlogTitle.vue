<template>
  <v-text-field
    :value="title"
    :error-messages="titleErrors"
    :counter="maxCharCount"
    label="Title"
    required
    @input="$emit('update:title', $event), $v.title.$touch()"
    @blur="$v.title.$touch()"
    autofocus
    type="text"
  >
  </v-text-field>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { required, maxLength, minLength } from 'vuelidate/lib/validators'
export default {
  mixins: [validationMixin],
  validations: {
    title: { required, maxLength: maxLength(127), minLength: minLength(4) },
  },
  props: {
    title: {
      type: String,
    },
  },
  data() {
    return {
      maxCharCount: 127,
      minCharCount: 4,
    }
  },

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
}
</script>

<style></style>

<template>
  <div>
    <v-btn
      class="mr-4 primary"
      @click="$emit('submit')"
      :disabled="submitStatus === 'PENDING'"
    >
      submit
    </v-btn>
    <v-btn @click="$emit('clear')">
      clear
    </v-btn>
    <div class="mt-5"></div>
    <p class="typo__p success--text" v-if="submitStatus === 'OK'">
      Thanks for your submission!
    </p>
    <p class="typo__p error--text" v-if="submitStatus === 'ERROR'">
      Please fill the form correctly.
    </p>
    <p class="typo__p" v-if="submitStatus === 'PENDING'">Sending...</p>
  </div>
</template>

<script>
export default {
  props: {
    submitStatus: {
      type: String,
    },
  },
}
</script>

<style></style>

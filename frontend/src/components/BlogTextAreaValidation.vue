<template>
  <v-row
    v-if="blogElement.type === 'textArea'"
    class="d-flex align-center mx-1 mt-0 mb-0"
  >
    <v-text-field
      class="d-flex mr-auto pt-0 mt-0"
      hidden
      style=" min-width:85%; max-width:93%; flex: 1 1 auto; "
      v-model="blogElement.content"
      :error-messages="textAreaErrors"
    />
    <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
    <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
    <v-spacer class="d-lg-none d-xl-none d-md-none d-sm-none" />
  </v-row>
</template>

<script>
export default {
  props: {
    blogElement: {
      type: Object,
    },
    textAreaErrors: {
      type: Array,
    },
  },
}
</script>

<style></style>

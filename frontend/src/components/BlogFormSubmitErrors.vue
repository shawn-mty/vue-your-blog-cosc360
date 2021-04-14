<template>
  <div>
    <v-row
      class="d-flex align-center mx-1 mb-0"
      v-if="submitStatus === 'TOOMANYTEXTAREAS'"
    >
      <p class="error--text mb-0 mr-2">
        Max number of Blog
        <br class="d-sm-none d-md-none d-lg-none d-xl-none" />
        Text Sections is {{ maxTextAreas }}
      </p>
      <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
      <v-btn @click="$emit('update:submitStatus', '')" class="info">Okay</v-btn>
    </v-row>
    <v-row
      class="d-flex align-center mx-1 mb-0"
      v-if="submitStatus === 'TOOMANYIMAGES'"
    >
      <p class="error--text mb-0 mr-2">
        Max number of Images is {{ maxImages }}
      </p>
      <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
      <v-btn @click="$emit('update:submitStatus', '')" class="info">
        Okay
      </v-btn>
    </v-row>
    <v-row
      class="d-flex align-center mx-1 mb-0"
      v-if="submitStatus === 'TOOMANYTEXTAREASANDIMAGES'"
    >
      <p class="error--text mb-0 mr-2">
        Max number of Images is {{ maxImages }} <br />
        Max number of Blog Text Sections is {{ maxTextAreas }}
      </p>
      <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
      <v-btn @click="$emit('update:submitStatus', '')" class="info">
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
      <v-btn @click="$emit('update:submitStatus', 'asdf')" class="info  my-4">
        Okay
      </v-btn>
    </v-row>
    <v-row
      class="d-flex align-center mx-1 mb-0"
      v-if="submitStatus === 'NOTEXTAREASORIMAGES'"
    >
      <p class="error--text mb-0 mr-2 ">
        Must have a Blog Text Section<br
          class="d-sm-none d-md-none d-lg-none d-xl-none"
        />
        and an Image to submit
      </p>
      <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
      <v-btn @click="$emit('update:submitStatus', 'asdf')" class="info  my-4">
        Okay
      </v-btn>
    </v-row>
    <v-row
      class="d-flex align-center mx-1 mb-0"
      v-if="submitStatus === 'NOIMAGES'"
    >
      <p class="error--text mb-0 mr-2 ">
        Must have at least one<br
          class="d-sm-none d-md-none d-lg-none d-xl-none"
        />
        Image to submit
      </p>
      <v-spacer class="d-sm-none d-md-none d-lg-none d-xl-none" />
      <v-btn @click="$emit('update:submitStatus', 'asdf')" class="info  my-4">
        Okay
      </v-btn>
    </v-row>

    <v-spacer v-else />
  </div>
</template>

<script>
export default {
  props: {
    submitStatus: {
      type: String,
    },
    maxImages: {
      type: Number,
    },
    maxTextAreas: {
      type: Number,
    },
  },
}
</script>

<style></style>

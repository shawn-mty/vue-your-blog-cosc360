<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <div class="d-flex align-center">
        <router-link to="/">
          <h1 class=" white--text">Vue Your Blog</h1>
        </router-link>
      </div>

      <v-spacer></v-spacer>
      <v-btn text to="/register">
        <span>Register</span>
      </v-btn>
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: 'App',

  data: () => ({
    //
  }),
}
</script>

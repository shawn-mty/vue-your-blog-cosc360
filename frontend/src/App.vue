<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <div class="d-flex align-center">
        <router-link to="/">
          <h1 class=" white--text">Vue Your Blog</h1>
        </router-link>
      </div>
      <v-spacer></v-spacer>
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
    <v-footer color="primary lighten-1" padless>
      <v-row justify="center" no-gutters>
        <v-btn
          v-for="link in links"
          :key="link"
          color="white"
          text
          rounded
          class="my-2"
          :to="link.path"
        >
          {{ link.name }}
        </v-btn>
      </v-row>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  name: 'App',

  data: () => ({
    links: [
      { path: '/', name: 'Home' },
      { path: '/register', name: 'Register' },
    ],
  }),
}
</script>

<template>
  <v-app id="inspire">
    <v-app-bar color="primary" dark>
      <div class="d-flex align-center">
        <router-link to="/">
          <h1 class=" white--text">Vue Your Blog</h1>
        </router-link>
      </div>

      <v-container class="py-0 fill-height">
        <v-btn
          v-for="item in links"
          :key="item.title"
          router
          :to="item.link"
          text="item.title;"
        >
          {{ item.title }}
        </v-btn>

        <v-spacer></v-spacer>

        <v-responsive max-width="260">
          <v-text-field
            dense
            flat
            hide-details
            rounded
            solo-inverted
          ></v-text-field>
        </v-responsive>
      </v-container>
    </v-app-bar>

    <v-main class="grey lighten-3">
      <router-view />
    </v-main>
  </v-app>
</template>

<!--/Links will have to be changed once we create those pages, check that your page name matches those links/-->
<script>
export default {
  data: () => ({
    links: [
      { title: 'Home', link: '/' },
      { title: 'About', link: '/about' },
      { title: 'Sign-in', link: '/signin' },
      { title: 'Register', link: '/register' },
      { title: 'Profile', link: '/profile' },
      { title: 'Sign-out', link: '/signout' },
    ],
  }),
}
</script>

<!--/      <v-spacer></v-spacer>
      <v-btn text to="/register">
        <span>Register</span>
      </v-btn>
    </v-app-bar>/-->

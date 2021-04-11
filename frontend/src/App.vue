<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <router-link to="/">
        <v-toolbar-title to="/" class=" white--text">
          VYB
        </v-toolbar-title>
      </router-link>

      <v-spacer></v-spacer>

      <div>
        <v-btn
          v-for="headerLink in headerLinks"
          :key="headerLink.index"
          color="white"
          text
          rounded
          class="my-2"
          :to="headerLink.path"
        >
          <v-icon>
            {{ headerLink.icon }}
          </v-icon>
        </v-btn>
      </div>

      <v-app-bar-nav-icon @click.stop="drawer = !drawer"
        ><v-icon> mdi-account</v-icon></v-app-bar-nav-icon
      >
    </v-app-bar>

    <v-main>
      <v-navigation-drawer
        style="z-index: 100"
        v-model="drawer"
        right
        temporary
        fixed
      >
        <template v-slot:prepend>
          <v-list-item two-line>
            <v-list-item-avatar>
              <img src="https://randomuser.me/api/portraits/women/81.jpg" />
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title>A USER TODO</v-list-item-title>
              <v-list-item-subtitle>Logged In TODO</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </template>

        <v-divider></v-divider>

        <v-list dense>
          <v-list-item v-for="item in userLinks" :key="item.title">
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>{{ item.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>

      <router-view class="mt-2" />
    </v-main>
    <v-footer color="primary lighten-1" padless>
      <v-row justify="center" no-gutters>
        <v-btn
          v-for="footerLink in footerLinks"
          :key="footerLink.index"
          color="white"
          text
          rounded
          class="my-2"
          :to="footerLink.path"
        >
          {{ footerLink.name }}
        </v-btn>
      </v-row>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  name: 'App',

  data: () => ({
    signedIn: true,
    userLinks: [{ path: '/profile', name: 'Profile', icon: 'mdi-account' }],
    headerLinks: [
      { path: '/signin', name: 'Sign In', icon: 'mdi-login-variant' },
      { path: '/register', name: 'Register', icon: 'mdi-account-plus' },
    ],
    footerLinks: [
      { path: '/', name: 'See Blogs' },
      { path: '/make-a-blog', name: 'Make a Blog' },
    ],
    drawer: false,
    group: null,
  }),
  watch: {
    group() {
      this.drawer = false
    },
  },
}
</script>
<style>
body,
html {
  overflow-wrap: anywhere !important;
}
</style>

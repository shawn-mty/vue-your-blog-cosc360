<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <router-link to="/">
        <v-toolbar-title to="/" class=" white--text">
          VYB
        </v-toolbar-title>
      </router-link>

      <v-spacer></v-spacer>

      <div v-for="headerLink in headerLinks" :key="headerLink.index">
        <div v-if="!currentUser.isSignedIn && headerLink.name !== 'Search'">
          <v-btn color="white" text rounded class="my-2" :to="headerLink.path">
            <v-app-bar-nav-icon>
              <v-icon class="mr-1">
                {{ headerLink.icon }}
              </v-icon>
            </v-app-bar-nav-icon>
            <div v-if="!$vuetify.breakpoint.xsOnly">
              {{ headerLink.name }}
            </div>
          </v-btn>
        </div>
      </div>
      <v-dialog v-model="dialog" persistent max-width="400">
        <template v-slot:activator="{ on, attrs }">
          <v-app-bar-nav-icon>
            <v-icon v-bind="attrs" v-on="on">
              mdi-magnify
            </v-icon>
          </v-app-bar-nav-icon>
        </template>
        <v-card>
          <v-chip-group color="primary" mandatory class=" ml-2">
            <v-chip filter>Blogs</v-chip>
            <v-chip filter>Comments</v-chip>
          </v-chip-group>

          <v-spacer></v-spacer>
          <v-text-field
            v-model="searchInput"
            :loading="loading"
            class="mx-4"
            flat
            hide-details
            label="Enter Words Here"
          ></v-text-field>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" text @click="dialog = false">
              <v-icon class="mr-2">mdi-magnify</v-icon> Search
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-app-bar-nav-icon
        v-if="currentUser.isSignedIn"
        @click.stop="drawer = !drawer"
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
              <img :src="currentUser.profileImageURL" />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title>A USER TODO</v-list-item-title>
              <v-list-item-subtitle>Logged In TODO</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </template>

        <v-divider></v-divider>

        <v-list dense>
          <v-list-item
            v-for="item in userLinks"
            :key="item.name"
            :to="item.path"
            @click="handleUserLink(item.name)"
          >
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
        <div v-for="footerLink in footerLinks" :key="footerLink.index">
          <v-btn
            v-if="currentUser.isSignedIn && footerLink.key === 'make-a-blog'"
            color="white"
            text
            rounded
            class="my-2"
            :to="footerLink.path"
          >
            {{ footerLink.name }}
          </v-btn>
          <v-btn
            v-if="footerLink.key === 'see-blogs'"
            color="white"
            text
            rounded
            class="my-2"
            :to="footerLink.path"
          >
            {{ footerLink.name }}
          </v-btn>
        </div>
      </v-row>
    </v-footer>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import EventService from '@/services/EventService'

export default {
  name: 'App',
  data: () => ({
    dialog: false,
    search: null,
    userLinks: [
      { path: '/profile', name: 'Profile', icon: 'mdi-account' },
      { path: '/admin', name: 'Admin', icon: 'mdi-cog' },
      { path: '/', name: 'Logout', icon: 'mdi-logout-variant' },
    ],
    headerLinks: [
      { path: '/signin', name: 'Sign In', icon: 'mdi-login-variant' },
      { path: '/register', name: 'Register', icon: 'mdi-account-plus' },
    ],
    footerLinks: [
      { path: '/', name: 'See Blogs', key: 'see-blogs' },
      { path: '/make-a-blog', name: 'Make a Blog', key: 'make-a-blog' },
    ],
    searchItems: [],
    drawer: false,
    group: null,
    searchInput: null,
    loading: false,
  }),
  watch: {
    group() {
      this.drawer = false
    },
  },
  methods: {
    querySelections() {
      //for the search bar
      this.loading = true
      // Simulated ajax query
      setTimeout(() => {
        //don't need to get search items

        this.loading = false
      }, 500)
    },
    handleUserLink(linkName) {
      if (linkName === 'Logout') {
        EventService.logout().then(() => {
          this.$store.commit('setCurrentUser', {
            id: '',
            isSignedIn: false,
            profileImagePath: '',
            username: '',
          })
          this.drawer = false
        })
      }
    },
  },
  computed: {
    ...mapGetters({ currentUser: 'getCurrentUserData' }),
  },
}
</script>
<style>
body,
html {
  overflow-wrap: anywhere !important;
}
</style>

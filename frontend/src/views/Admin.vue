<template>
  <v-container v-if="user.isAdmin">
    <v-dialog v-model="dialog" persistent max-width="400">
      <template v-slot:activator="{ on, attrs }">
        <v-row class="d-flex justify-center my-5">
          <v-btn v-bind="attrs" v-on="on" color="primary">
            <v-icon class="mr-2" v-bind="attrs" v-on="on"> mdi-account </v-icon>
            User Search
            <v-icon class="ml-2" v-bind="attrs" v-on="on"> mdi-magnify </v-icon>
          </v-btn>
        </v-row>
      </template>
      <v-card>
        <v-chip-group
          v-model="searchType"
          color="primary"
          mandatory
          class=" ml-3"
        >
          <v-chip :value="'username'" filter>Username</v-chip>
          <v-chip :value="'email'" filter>Email</v-chip>
          <v-chip :value="'blog'" filter>Blog Title </v-chip>
        </v-chip-group>

        <v-spacer></v-spacer>
        <v-text-field
          autofocus
          @keyup.enter="handleSearch"
          v-model="searchInput"
          class="mx-4"
          flat
          hide-details
          label="Enter Words Here"
        ></v-text-field>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="secondary" text @click="handleSearch">
            <v-icon class="mr-2">mdi-autorenew</v-icon> Restore
          </v-btn>
          <v-btn color="primary" text @click="handleSearch">
            <v-icon class="mr-2">mdi-magnify</v-icon> Search
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-row class="d-flex justify-center mt-5">
      <ol>
        <li>Enable/disable users</li>
        <li>Edit/remove posts and comments</li>
      </ol>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import { adminUserSearch } from '@/services/EventService'

export default {
  data() {
    return {
      dialog: false,
      searchInput: '',
      searchType: '',
    }
  },
  created() {},
  computed: {
    ...mapGetters({ user: 'getCurrentUserData' }),
  },
  methods: {
    handleSearch() {
      this.dialog = false
      this.userSearch()
      this.searchInput = ''
    },
    async userSearch() {
      await adminUserSearch({
        searchInput: this.searchInput,
        searchType: this.searchType,
      })
    },
  },
}
</script>

<style></style>

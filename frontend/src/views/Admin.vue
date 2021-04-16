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
          <v-chip :value="'blog'" filter>Blog </v-chip>
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

    <v-list max-width="400" class="mx-auto ">
      <v-list-item v-for="user in users" :key="user.index">
        <v-list-item-title class="mr-5">{{ user.title }}</v-list-item-title>
        <v-list-item-subtitle>
          {{ user.subtitle }}
        </v-list-item-subtitle>
        <v-btn
          v-if="!user.disabled"
          @click="disableUser(user.id, user.disabled)"
          small
          class="error "
        >
          <v-icon>mdi-account-off</v-icon>
        </v-btn>
        <v-btn
          v-if="user.disabled"
          @click="disableUser(user.id, user.disabled)"
          small
          class="success "
        >
          <v-icon>mdi-account-check</v-icon>
        </v-btn>
      </v-list-item>
    </v-list>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import { adminUserSearch } from '@/services/EventService'
import { disable } from '@/services/EventService'

export default {
  data() {
    return {
      dialog: false,
      searchInput: '',
      searchType: '',
      users: [],
    }
  },
  created() {},
  computed: {
    ...mapGetters({ user: 'getCurrentUserData' }),
  },
  methods: {
    async disableUser(id, disabled) {
      await disable({
        userId: id,
        disable: !disabled,
      })

      for (let i = 0; i < this.users.length; i++) {
        if (this.users[i].id === id) {
          this.users[i].disabled = !disabled
        }
      }
    },

    handleSearch() {
      this.dialog = false
      this.userSearch()
      this.searchInput = ''
    },
    async userSearch() {
      const adminSearchResults = await adminUserSearch({
        searchInput: this.searchInput,
        searchType: this.searchType,
      })
      this.users = adminSearchResults.data.matchWithInput
    },
  },
}
</script>

<style></style>

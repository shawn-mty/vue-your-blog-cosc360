<template>
  <v-container class="mt-5">
    <v-btn
      v-if="comments.length > 0 || currentUser.isSignedIn"
      @click="commentToggle = !commentToggle"
      class="secondary font-weight-bold mb-3"
      >Comments</v-btn
    >
    <v-row class="mt-5">
      <transition-group
        v-show="commentToggle"
        three-line
        v-for="item in comments"
        :key="item.index"
        style="width:100%;"
      >
        <v-list-item :key="item.username">
          <v-list-item-avatar>
            <v-img :src="'http://localhost:3000/' + item.avatar"></v-img>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title
              class="font-weight-bold secondary--text"
              v-html="item.username"
            ></v-list-item-title>
            <v-list-item-content v-html="item.message"></v-list-item-content>
            <v-list-item-subtitle v-html="item.time"></v-list-item-subtitle>
            <v-divider />
          </v-list-item-content>
        </v-list-item>
      </transition-group>
    </v-row>

    <v-row
      class="mt-5"
      v-if="currentUserComment.show && commentToggle && currentUser.isSignedIn"
    >
      <CommentTextArea
        v-if="currentUserComment.show"
        :comment.sync="currentUserComment"
        class="mt-2"
      />
    </v-row>
    <v-row
      v-if="commentToggle && currentUser.isSignedIn"
      class="d-flex justify-end mr-2"
    >
      <v-col
        v-if="commentError"
        class="d-flex justify-center align-center mt-5 mr-2"
      >
        <div class="mt-5  error--text">{{ commentError }}</div>
      </v-col>
      <v-col class="d-flex justify-end mt-5 mr-2">
        <v-btn class="mt-5 mr-2" @click="submit" color="primary">
          Submit
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CommentTextArea from './CommentTextArea.vue'
import { createComment } from '@/services/EventService'
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({ currentUser: 'getCurrentUserData' }),
  },
  components: { CommentTextArea },
  props: {
    comments: {
      type: Array,
    },
  },
  mounted() {
    this.currentUserComment.show = true
  },
  data() {
    return {
      currentUserComment: { show: false, content: '' },
      commentToggle: true,
      commentError: '',
    }
  },
  methods: {
    async submit() {
      if (
        this.currentUserComment.content &&
        this.currentUserComment.content.length <= 511 &&
        this.currentUserComment.content.length > 0
      ) {
        const commentSent = await createComment({
          message: this.currentUserComment.content,
          blogId: this.$route.params.id,
          avatar: this.currentUser.profileImagePath,
          username: this.currentUser.username,
        })

        if (commentSent.data.success) {
          this.$emit('updatePage')
          this.currentUserComment.content = ''
        }
      } else if (
        !this.currentUserComment.content.length <= 511 &&
        this.currentUserComment.content.length > 0
      ) {
        this.commentError =
          'Message length ' +
          this.currentUserComment.content.length +
          ' must be below 512 characters'
      } else if (this.currentUserComment.content.length === 0) {
        this.commentError = 'Message length '
        ;(' must have more than 0 characters')
      }
    },
  },
}
</script>

<style></style>

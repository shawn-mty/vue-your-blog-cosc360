<template>
  <v-container class="mt-5">
    <v-row>
      <v-btn
        @click="commentToggle = !commentToggle"
        class="secondary--text font-weight-bold mb-3"
        >Comments</v-btn
      >

      <transition-group
        v-show="commentToggle"
        three-line
        v-for="item in comments"
        :key="item.index"
      >
        <v-list-item :key="item.username">
          <v-list-item-avatar>
            <v-img :src="item.avatar"></v-img>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title v-html="item.username"></v-list-item-title>
            <v-list-item-content v-html="item.message"></v-list-item-content>
            <v-list-item-subtitle v-html="item.time"></v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </transition-group>
    </v-row>

    <v-row class="mt-5" v-if="currentUserComment.show && commentToggle">
      <CommentTextArea
        v-if="currentUserComment.show"
        :comment.sync="currentUserComment"
        class="mt-2"
      />
    </v-row>
    <v-row v-if="commentToggle" class="d-flex justify-end mt-5 mr-2">
      <v-btn class="mt-5 mr-5" @click="submit" color="primary">
        Submit
      </v-btn>
    </v-row>
  </v-container>
</template>

<script>
import CommentTextArea from './CommentTextArea.vue'
export default {
  components: { CommentTextArea },
  mounted() {
    this.currentUserComment.show = true
  },
  data() {
    return {
      currentUserComment: { show: false, content: '' },
      commentToggle: true,
      comments: [
        {
          username: 'EpicPerson123',
          message:
            '<strong>asdfasdfasdf</strong>Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. <strong>asdfasdfasdf</strong>Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. ',
          avatar: 'http://localhost:3000/uploads/Shawn-tripped.png',
          time: new Date().toLocaleString('en-us', {
            month: 'short',
            year: 'numeric',
            timeZoneName: 'short',
            hour: 'numeric',
            minute: 'numeric',
          }),
        },
        {
          message:
            'OMG I LOVE Cats and beer they are the best things, blablablablalbalblalba sammiches OMG I LOVE Cats and beer they are the best things, blablablablalbalblalba sammiches OMG I LOVE Cats and beer they are the best things, blablablablalbalblalba sammiches OMG I LOVE Cats and beer they are the best things, blablablablalbalblalba sammiches ',
          username: 'CatBeer623',
          avatar: 'http://localhost:3000/uploads/shawn-face.jfif',
          time: new Date().toLocaleString('en-us', {
            month: 'short',
            year: 'numeric',
            timeZoneName: 'short',
            hour: 'numeric',
            minute: 'numeric',
          }),
        },
      ],
    }
  },
  methods: {
    submit() {
      alert(this.currentUserComment.content)
    },
  },
}
</script>

<style></style>

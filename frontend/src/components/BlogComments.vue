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
            <v-list-item-content>{{ item.message }}</v-list-item-content>
            <v-list-item-subtitle v-html="item.time"></v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </transition-group>
    </v-row>
  </v-container>
</template>

<script>
export default {
  created() {},
  data() {
    return {
      commentToggle: true,
      comments: [
        {
          username: 'EpicPerson123',
          message:
            'Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. Blabal balblabala cats blalbalba beer Blabal balblabala cats blalbalba beer. ',
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
}
</script>

<style></style>

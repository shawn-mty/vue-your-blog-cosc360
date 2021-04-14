<template>
  <tiptap-vuetify
    class="d-flex mr-auto"
    style="width: 85%; min-width:85%; max-width:95%; flex: 1 1 auto; "
    :card-props="{ width: '98%' }"
    v-if="blogElements[blogElementIndex].type == 'textArea'"
    v-model="blogElements[blogElementIndex].content"
    @blur="nullTextOnLowCharCount"
    :extensions="extensions"
    placeholder="Write a section of your blog here"
    required
  />
</template>

<script>
import {
  TiptapVuetify,
  Heading,
  Bold,
  Italic,
  Strike,
  Underline,
  Code,
  Paragraph,
  BulletList,
  OrderedList,
  ListItem,
  Link,
  Blockquote,
  HardBreak,
  History,
} from 'tiptap-vuetify'
export default {
  props: {
    blogElements: {
      type: Array,
    },
    blogElementIndex: {
      type: Number,
    },
  },
  data() {
    return {
      extensions: [
        History,
        Blockquote,
        Link,
        Underline,
        Strike,
        Italic,
        ListItem,
        BulletList,
        OrderedList,
        [
          Heading,
          {
            options: {
              levels: [2, 3],
            },
          },
        ],
        Bold,
        Code,
        Paragraph,
        HardBreak,
      ],
    }
  },
  components: {
    TiptapVuetify,
  },
  methods: {
    nullTextOnLowCharCount() {
      this.blogElements[this.blogElementIndex].content &&
      this.blogElements[this.blogElementIndex].content.length < 10 &&
      this.blogElements[this.blogElementIndex].content.includes('<')
        ? (this.blogElements[this.blogElementIndex].content = null)
        : true
    },
  },
}
</script>

<style></style>

<template lang="pug">
form(@submit.prevent="submit")
  .form-group
    label(for="contentInput") Content
    input#contentInput.form-control(v-model="post.content")
  button(type="submit") Submit
</template>

<script>
export default {
  props: ['post'],
  methods: {
    submit: function () {
      this.$store.dispatch('posts/create', { post: this.post }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

<template lang="pug">
form(@submit.prevent="submit")
  .form-group
    label(for="titleInput") Title
    input#titleInput.form-control(v-model="post.title")
  .form-group
    label(for="contentInput") Content
    textarea#contentInput.form-control(v-model="post.content")
  button.btn.btn-primary(type="submit") Submit
</template>

<script>
export default {
  props: [
    'post',
    'submit'
  ]
}
</script>

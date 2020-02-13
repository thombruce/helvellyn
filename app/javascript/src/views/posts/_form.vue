<template lang="pug">
form(@submit.prevent="submit")
  .form-group
    label(for="contentInput") Content
    input#contentInput.form-control(v-model="post.content")
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

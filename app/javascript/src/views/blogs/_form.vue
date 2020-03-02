<template lang="pug">
form(@submit.prevent="submit")
  .form-group
    label(for="titleInput") Title
    input#titleInput.form-control(v-model="blog.title")
  button.btn.btn-primary(type="submit") Submit
</template>

<script>
export default {
  props: [
    'blog',
    'submit'
  ]
}
</script>

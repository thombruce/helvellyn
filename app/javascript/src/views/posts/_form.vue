<template lang="pug">
form()
  .form-group
    label(for="contentInput") Content
    input#contentInput.form-control()
  button Submit
</template>

<script>
export default {
  props: ['post']
}
</script>

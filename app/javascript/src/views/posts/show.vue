<template lang="pug">
layout
  h1 Post
  p Content
  router-link(:to="{ name: 'edit_post_path' }") Edit
</template>

<script>
export default {}
</script>

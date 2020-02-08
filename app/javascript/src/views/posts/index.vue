<template lang="pug">
layout
  h1 Posts
  p List of posts
  router-link(:to="{ name: 'new_post_path' }") New post
</template>

<script>
export default {}
</script>

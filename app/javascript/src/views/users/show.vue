<template lang="pug">
layout
  h1 User
  p Username
  router-link(:to="{ name: 'edit_user_path' }") Edit
</template>

<script>
export default {}
</script>

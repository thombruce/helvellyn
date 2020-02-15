<template lang="pug">
.col-md-auto.bg-dark
  nav.nav.flex-column
    router-link.nav-link(:to="{ name: 'posts_path' }") Posts
    router-link.nav-link(:to="{ name: 'posts_path' }") Posts
</template>

<script>
export default {}
</script>

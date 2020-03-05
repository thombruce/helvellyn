<template lang="pug">
.bg-dark
  nav.nav.flex-column
    #accordion
      a.nav-link(data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" href="#") Posts
      #collapseOne.collapse(data-parent="#accordion")
        router-link.nav-link(:to="{ name: 'posts_path' }") All
        router-link.nav-link(:to="{ name: 'new_post_path' }") New Post
      a.nav-link(data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo" href="#") Other
      #collapseTwo.collapse(data-parent="#accordion")
        router-link.nav-link(:to="{ name: 'posts_path' }") All
        router-link.nav-link(:to="{ name: 'new_post_path' }") New Other
      router-link.nav-link(:to="{ name: 'posts_path' }") New +
</template>

<script>
export default {}
</script>

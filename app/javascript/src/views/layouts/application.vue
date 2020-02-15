<template lang="pug">
div
  navbar
  .container-fluid
    .row
      sidebar
      .col
        slot
</template>

<script>
import Navbar from './_navbar.vue'
import Sidebar from './_sidebar.vue'
export default {
  components: {
    Navbar,
    Sidebar
  }
}
</script>
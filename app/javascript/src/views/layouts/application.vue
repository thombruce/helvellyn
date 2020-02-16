<template lang="pug">
.d-flex.flex-column(style="height:100vh;")
  navbar
  .flex-grow-1.d-flex
    sidebar.h-100(style="min-width:150px;")
    div.container
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
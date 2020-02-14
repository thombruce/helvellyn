<template lang="pug">
div
  navbar
  .container
    slot
</template>

<script>
import Navbar from './_navbar.vue'
export default {
  components: {
    Navbar
  }
}
</script>
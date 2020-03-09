<template lang="pug">
v-app
  navbar
  v-content
    v-container
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
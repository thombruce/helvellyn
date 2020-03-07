<template lang="pug">
v-app
  navbar
  v-content
    v-container
      v-row(justify="center")
        v-col(cols="12" sm="8")
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
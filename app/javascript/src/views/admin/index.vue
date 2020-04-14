<template lang="pug">
v-card(outlined)
  v-card-title Helvellyn
  v-card-subtitle
    span.subtitle-1
      strong Version
      |
      | {{ $store.getters.appVersion }}
  v-card-text
    p Thank you for using Helvellyn CMS.
</template>

<script>
export default {}
</script>

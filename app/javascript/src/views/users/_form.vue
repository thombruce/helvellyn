<template lang="pug">
v-form(ref="form" :model="user")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'user',
    'submit'
  ],
  computed: {},
  methods: {}
}
</script>

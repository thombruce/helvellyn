<template lang="pug">
v-form(ref="form" :model="user")
  v-text-field(label="Name" v-model="user.name")
  v-text-field(label="Email" v-model="user.email")
  v-text-field(label="Password" type="password" v-model="user.password")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'user',
    'submit'
  ]
}
</script>

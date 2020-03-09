<template lang="pug">
v-form(ref="form" :model="content_type")
  v-text-field(label="Title" v-model="content_type.title")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'content_type',
    'submit'
  ]
}
</script>

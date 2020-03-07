<template lang="pug">
v-form(ref="form" :model="workspace")
  v-text-field(label="Title" v-model="workspace.title")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'workspace',
    'submit'
  ]
}
</script>

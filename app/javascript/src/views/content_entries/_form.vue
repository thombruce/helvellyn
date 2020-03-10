<template lang="pug">
v-form(ref="form" :model="content_entry")
  template(v-for="field in content_type.fields")
    v-text-field(:label="field.name" v-model="content_entry[field.slug]")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'content_type',
    'content_entry',
    'submit'
  ]
}
</script>

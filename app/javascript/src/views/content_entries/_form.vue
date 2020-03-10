<template lang="pug">
v-form(ref="form" :model="content_entry")
  template(v-for="field in content_entry.fields")
    h3 New Field
    v-text-field(label="Name" v-model="field.name")
    v-select(label="Type" :items="['String', 'Text']" v-model="field.type")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'content_entry',
    'submit'
  ],
  methods: {
    addField () {
      this.content_entry.fields.push({ name: '', type: '' })
    }
  }
}
</script>

<template lang="pug">
v-form(ref="form" :model="content_type")
  v-text-field(label="Name" v-model="content_type.name")
  template(v-for="field in content_type.fields")
    h3 New Field
    v-text-field(label="Name" v-model="field.name")
    v-select(label="Type" :items="['String', 'Text']" v-model="field.type")
  v-btn(color="primary" @click="addField") Add Field
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
export default {
  props: [
    'content_type',
    'submit'
  ],
  methods: {
    addField () {
      this.content_type.fields.push({ name: '', type: '' })
    }
  }
}
</script>

<template lang="pug">
v-form(ref="form" :model="content_type")
  v-text-field(label="Name" v-model="content_type.name")

  v-dynamic-field-form(v-for="(field, i) in content_type.fields" v-model="content_type.fields[i]")

  v-btn(color="primary" @click="addField") Add Field

  v-btn(color="primary" @click="submit") Submit
</template>

<script>
import VDynamicFieldForm from '../../components/VDynamicFieldForm.vue'

export default {
  props: [
    'content_type',
    'submit'
  ],
  components: {
    VDynamicFieldForm
  },
  methods: {
    addField () {
      this.content_type.fields.push({ name: '', type: '' })
    }
  }
}
</script>

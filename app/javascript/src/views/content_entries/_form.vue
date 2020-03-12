<template lang="pug">
v-form(ref="form" :model="content_entry")
  v-switch(v-model="content_entry.published" label="Publish")
  v-dynamic-field(v-for="field in content_type.fields" :label="field.name" :type="field.type" v-model="content_entry[field.slug]")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
import VDynamicField from '../../components/VDynamicField.vue'

export default {
  props: [
    'content_type',
    'content_entry',
    'submit'
  ],
  components: {
    VDynamicField
  }
}
</script>

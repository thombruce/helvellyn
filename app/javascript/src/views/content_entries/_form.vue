<template lang="pug">
v-form(ref="form" :model="content_entry")
  dynamic-field(v-for="field in content_type.fields" :model="content_entry" :field="field")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
import DynamicField from './_dynamicField.vue'

export default {
  props: [
    'content_type',
    'content_entry',
    'submit'
  ],
  components: {
    DynamicField
  }
}
</script>

<template lang="pug">
div
  h4 {{ inputVal.name || 'New Field' }}

  v-row
    v-col(cols="12" sm="6")
      v-text-field(label="Name" v-model="inputVal.name")
    v-col(cols="12" sm="6")
      v-dynamic-field-type-select(label="Type" v-model="inputVal.type")
      v-switch(v-if="canSlug" v-model="inputVal.sluggable" label="Sluggable" hint="Use this field to create a URL friendly ID")
</template>

<script>
import VDynamicFieldTypeSelect from './VDynamicFieldTypeSelect.vue'

export default {
  props: [
    'value'
  ],
  components: {
    VDynamicFieldTypeSelect
  },
  computed: {
    inputVal: {
      get() {
        return this.value
      },
      set(val) {
        this.$emit('input', val)
      }
    },
    canSlug () {
      if (this.inputVal.type === 'String') {
        return true
      }
    }
  }
}
</script>

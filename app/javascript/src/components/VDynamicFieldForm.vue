<template lang="pug">
div
  h3 New Field

  v-text-field(label="Name" v-model="inputVal.name")

  v-dynamic-field-type-select(label="Type" v-model="inputVal.type")
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
    }
  }
}
</script>

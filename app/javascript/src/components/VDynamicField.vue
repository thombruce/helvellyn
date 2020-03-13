<template lang="pug">
component(:is="fieldComponent" :label="label" v-model="inputVal" :error-messages="errorMessages")
</template>

<script>
import VWysiwyg from './VWysiwyg.vue'

export default {
  props: [
    'value',
    'label',
    'type',
    'errorMessages'
  ],
  components: {
    VWysiwyg
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
    fieldComponent() {
      switch(this.type) {
        case 'String':
          return 'v-text-field'
        case 'Text':
          return 'v-textarea'
        case 'Markdown':
          return 'v-wysiwyg'
        default:
          return 'v-text-field'
      }
    }
  }
}
</script>

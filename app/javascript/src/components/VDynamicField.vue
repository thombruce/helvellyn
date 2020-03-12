<template lang="pug">
component(:is="fieldComponent" :label="label" v-model="inputVal")
</template>

<script>
import VWysiwyg from './VWysiwyg.vue'

export default {
  props: [
    'value',
    'label',
    'type'
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
          return 'v-wysiwyg'
        default:
          return 'v-text-field'
      }
    }
  }
}
</script>

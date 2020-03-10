<template lang="pug">
component(:is="fieldComponent" :label="field.name" v-model="model[field.slug]")
</template>

<script>
import VWysiwyg from '../../components/VWysiwyg.vue'

export default {
  props: [
    'model',
    'field'
  ],
  components: {
    VWysiwyg
  },
  computed: {
    fieldComponent() {
      switch(this.field.type) {
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

<template lang="pug">
v-card.mb-5
  v-container
    h4 {{ inputVal.name || 'New Field' }}

    v-row
      v-col(cols="12" sm="6")
        v-text-field(label="Name" v-model="inputVal.slug" @input="updateName($event)")
      v-col(cols="12" sm="6")
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
    },
    canSlug () {
      if (this.inputVal.type === 'String') {
        return true
      }
    }
  },
  methods: {
    updateName(value) {
      this.value.slug = value.replace(/\s|-/g, '_').toLowerCase()
      this.value.name = this.value.slug.split('_').map((word) => {
        return word.charAt(0).toUpperCase() + word.substring(1)
      }).join(' ')
    }
  }
}
</script>

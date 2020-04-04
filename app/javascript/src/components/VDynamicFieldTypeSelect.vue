<template lang="pug">
v-select(:label="label" :items="fieldTypeOptions" v-model="inputVal")
</template>

<script>
export default {
  props: [
    'label',
    'value'
  ],
  data () {
    return {
      fieldTypeOptions: [
        'String',
        'Text',
        'Rich Text',
        'Markdown'
      ] // TODO: These should be key,value pairs with parameterized values (needs database change)
    }
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

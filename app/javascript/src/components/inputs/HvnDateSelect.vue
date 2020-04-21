<template lang="pug">
v-dialog(
  ref="dialog"
  v-model="dialog"
  width="290px"
)
  template(v-slot:activator="{ on }")
    v-text-field(
      v-model="inputVal"
      :label="label"
      prepend-icon="mdi-calendar"
      readonly
      v-on="on"
    )
  v-date-picker(v-model="inputVal" @input="dialog = false")
</template>

<script>
export default {
  props: [
    'label',
    'value'
  ],
  data () {
    return {
      dialog: false
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

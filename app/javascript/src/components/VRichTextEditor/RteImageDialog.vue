<template lang="pug">
v-dialog(v-model="dialog" persistent max-width="290")
  template(v-slot:activator="{ on }")
    v-btn(icon v-on="on")
      v-icon mdi-image
  v-card
    v-card-title(class="headline") Add an image
    v-form(@submit.prevent="setImageSrc(command, src)")
      v-card-text
        v-text-field.ma-0.pa-0(
          label="Image URL"
          v-model="src"
        )
    v-card-actions
      v-spacer
      v-btn(color="green darken-1" text @click="setImageSrc(command, src)") Submit
</template>

<script>
export default {
  props: ['command'],
  data() {
    return {
      dialog: false,
      src: null
    }
  },
  methods: {
    setImageSrc(command, src) {
      command({ src })
      this.dialog = false
    }
  }
}
</script>

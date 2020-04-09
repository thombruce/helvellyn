<template lang="pug">
v-dialog(v-model="dialog" persistent max-width="290")
  template(v-slot:activator="{ on }")
    v-btn(icon v-on="on")
      v-icon mdi-image
  v-card
    v-card-title(class="headline") Add an image
    v-form(@submit.prevent="setImageSrc(command, image)")
      v-card-text
        v-text-field.ma-0.pa-0(
          label="Image URL"
          v-model="image.src"
        )
        v-text-field.ma-0.pa-0(
          label="Alt Text"
          v-model="image.alt"
        )
        v-text-field.ma-0.pa-0(
          label="Hover Text"
          v-model="image.title"
        )
    v-card-actions
      v-spacer
      v-btn(color="green darken-1" text @click="setImageSrc(command, image)") Submit
</template>

<script>
export default {
  props: ['command'],
  data() {
    return {
      dialog: false,
      image: {
        src: null,
        alt: null,
        title: null
      }
    }
  },
  methods: {
    setImageSrc(command, image) {
      command(image)
      this.dialog = false
    }
  }
}
</script>

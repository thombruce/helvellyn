<template lang="pug">
v-form(ref="form" :model="content_entry")
  v-switch(v-model="content_entry.published" label="Publish")
  div(v-for="field in content_type.fields")
    v-dynamic-field(:label="field.name" :type="field.type" @input="field.sluggable ? updateSlug($event) : null" v-model="content_entry[field.slug]")
    v-text-field(v-if="field.sluggable" label="Slug" :prefix="contentTypeUrl" v-model="content_entry.slug" hint="The URL path of your content (e.g. my-first-post)")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
var parameterize = require('parameterize')
import VDynamicField from '../../components/VDynamicField.vue'

export default {
  props: [
    'content_type',
    'content_entry',
    'submit'
  ],
  components: {
    VDynamicField
  },
  computed: {
    contentTypeUrl() {
      return this.content_type.url.replace(/^http(s)?:\/\//, "").replace(/\.[^/.]+$/, "/")
    }
  },
  methods: {
    updateSlug (value) {
      if (!this.content_entry.id) {
        this.content_entry.slug = parameterize(value)
      }
    }
  }
}
</script>

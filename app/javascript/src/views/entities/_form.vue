<template lang="pug">
v-form(ref="form" :model="entity")
  v-switch(v-if="template.publishable" v-model="entity.published" :error-messages="entity.errors.published" label="Publish")
  div(v-for="field in template.fields")
    v-dynamic-field(:label="field.name" :type="field.type" @input="(field.slug == template.sluggable_field) ? updateSlug($event) : null" v-model="entity[field.slug]")
    v-text-field(v-if="field.slug == template.sluggable_field" label="Slug" :prefix="templateUrl" v-model="entity.slug" :error-messages="entity.errors.slug" hint="The URL path of your content (e.g. my-first-post)")
  v-btn(color="primary" @click="submit") Submit
</template>

<script>
var parameterize = require('parameterize')
import VDynamicField from '../../components/VDynamicField.vue'

export default {
  props: [
    'template',
    'entity',
    'submit'
  ],
  components: {
    VDynamicField
  },
  computed: {
    templateUrl() {
      return this.template.url.replace(/^http(s)?:\/\//, "").replace(/\.[^/.]+$/, "/")
    }
  },
  methods: {
    updateSlug (value) {
      if (!this.entity.id) {
        this.entity.slug = parameterize(value)
      }
    }
  }
}
</script>

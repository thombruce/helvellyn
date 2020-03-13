<template lang="pug">
v-form(ref="form" :model="content_type")
  v-alert(v-for="error in content_type.errors.base" type="error") {{ error }}

  v-text-field(label="Name" v-model="content_type.name" :error-messages="content_type.errors.name" @input="updatePlural();updateSlug()" hint="The name of your content type (e.g. Post)")

  v-text-field(label="Plural" v-model="content_type.plural" :error-messages="content_type.errors.plural" @input="updateSlug" hint="The plural name of your content type (e.g. Posts)")

  v-text-field(label="Slug" :prefix="workspaceUrl" v-model="content_type.slug" :error-messages="content_type.errors.slug" hint="The URL path of your content type (e.g. posts)")

  v-dynamic-field-form(v-for="(field, i) in content_type.fields" v-model="content_type.fields[i]")

  v-btn(color="primary" @click="addField") Add Field

  v-btn(color="primary" @click="submit") Submit
</template>

<script>
var parameterize = require('parameterize')
var pluralize = require('pluralize')

import VDynamicFieldForm from '../../components/VDynamicFieldForm.vue'

export default {
  props: [
    'workspace',
    'content_type',
    'submit'
  ],
  components: {
    VDynamicFieldForm
  },
  computed: {
    workspaceUrl() {
      return this.workspace.url.replace(/^http(s)?:\/\//, "").replace(/\.[^/.]+$/, "/")
    }
  },
  methods: {
    addField () {
      this.content_type.fields.push({ name: '', type: '' })
    },
    updatePlural () {
      if (!this.content_type.id) {
        this.content_type.plural = pluralize(this.content_type.name)
      }
    },
    updateSlug () {
      if (!this.content_type.id) {
        this.content_type.slug = parameterize(this.content_type.plural)
      }
    }
  }
}
</script>

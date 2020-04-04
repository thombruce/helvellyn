<template lang="pug">
v-form(ref="form" :model="content_type")
  v-alert(v-for="error in content_type.errors.base" type="error") {{ error }}

  h3 Ident

  v-text-field(label="Name" v-model="content_type.name" :error-messages="content_type.errors.name" @input="updatePlural();updateSlug()" hint="The name of your content type (e.g. Post)")

  v-text-field(label="Plural" v-model="content_type.plural" :error-messages="content_type.errors.plural" @input="updateSlug" hint="The plural name of your content type (e.g. Posts)")

  v-text-field(label="Slug" :prefix="workspaceUrl" v-model="content_type.slug" :error-messages="content_type.errors.slug" hint="The URL path of your content type (e.g. posts)")

  div.mb-5
    h3 Custom Fields

    v-dynamic-field-form(v-for="(field, i) in content_type.fields" v-model="content_type.fields[i]")

    v-dialog(v-model="dialog" persistent max-width="600px")
      template(v-slot:activator="{ on }")
        v-btn(color="primary" v-on="on") Add Field
      v-card
        v-card-title
          span(class="headline") New Field
        v-container
          v-row
            v-col(v-for="field_type in field_types" cols="12" sm="6")
              v-card(@click="addField(field_type.value)")
                v-card-text.text-center
                  v-icon(x-large) {{ field_type.icon }}
                  p.headline {{ field_type.text }}
        v-card-actions
          v-spacer
          v-btn(color="blue darken-1" text @click="dialog = false") Save

  v-btn(color="primary" @click="submit") Submit
</template>

<script>
var parameterize = require('parameterize')
var pluralize = require('pluralize')

import FieldTypes from '../../mixins/field_types.js'

import VDynamicFieldForm from '../../components/VDynamicFieldForm.vue'

export default {
  props: [
    'workspace',
    'content_type',
    'submit'
  ],
  mixins: [
    FieldTypes
  ],
  components: {
    VDynamicFieldForm
  },
  data() {
    return {
      dialog: false
    }
  },
  computed: {
    workspaceUrl() {
      return this.workspace.url.replace(/^http(s)?:\/\//, "").replace(/\.[^/.]+$/, "/")
    }
  },
  methods: {
    addField (type) {
      this.content_type.fields.push({ name: '', type: type })
      this.dialog = false
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

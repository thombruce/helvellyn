<template lang="pug">
v-form(ref="form" :model="template")
  v-alert(v-for="error in template.errors.base" type="error") {{ error }}

  h3 Ident

  v-text-field(label="Name" v-model="template.name" :error-messages="template.errors.name" @input="updatePlural();updateSlug()" hint="The name of your content type (e.g. Post)")

  v-text-field(label="Plural" v-model="template.plural" :error-messages="template.errors.plural" @input="updateSlug" hint="The plural name of your content type (e.g. Posts)")

  v-text-field(label="Slug" :prefix="workspaceUrl" v-model="template.slug" :error-messages="template.errors.slug" hint="The URL path of your content type (e.g. posts)")

  v-card.my-4
    v-card-text
      h3 Publishing Settings

      v-checkbox(v-model="template.publishable" label="Publishable" hint="Whether or not it should be possible to publish the content, making it public.")

      v-row
        v-col
          h4 API Ordering
          v-select(label="Order by" :items="sortCandidates" v-model="template.api_sort")
          v-checkbox(label="Most recent first" v-model="template.api_desc")

        v-col
          h4 Admin Ordering
          v-select(label="Order by" :items="sortCandidates" v-model="template.admin_sort")
          v-checkbox(label="Most recent first" v-model="template.admin_desc")

  v-card.my-4
    v-card-text
      h3 Custom Fields

      v-select(label="Slug" :items="sluggableCandidates" v-model="template.sluggable_field")

      v-dynamic-field-form(v-for="(field, i) in template.fields" v-model="template.fields[i]")

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
    'template',
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
      dialog: false,
      sortCandidates: [
        { text: 'Created', value: 'created_at' },
        { text: 'Updated', value: 'updated_at' },
        { text: 'Published', value: 'published_at' }
      ]
    }
  },
  computed: {
    workspaceUrl() {
      return this.workspace.url.replace(/^http(s)?:\/\//, "").replace(/\.[^/.]+$/, "/")
    },
    sluggableCandidates() {
      return this.template.fields
        .filter(field => field.type === 'String')
        .map((field) => {
          return { text: field.name, value: field.slug }
        })
    }
  },
  methods: {
    addField (type) {
      this.template.fields.push({ name: '', slug: '', type: type })
      this.dialog = false
    },
    updatePlural () {
      if (!this.template.id) {
        this.template.plural = pluralize(this.template.name)
      }
    },
    updateSlug () {
      if (!this.template.id) {
        this.template.slug = parameterize(this.template.plural)
      }
    }
  }
}
</script>

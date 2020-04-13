<template lang="pug">
div(v-if="template")
  h2 {{ template.plural }} Settings
  template-form(v-if="template" :workspace="workspace" :template="template", :submit="update")

  v-alert.my-4(
    type="error"
    colored-border
    border="left"
    elevation="2"
  )
    h4.title Danger Zone
    p.body-1 Your template cannot be restored if deleted. Please be certain this is what you want.
    p.body-2 You will also lose all of the entities associated with this template.
    v-dialog(v-model="dialog" persistent max-width="600px")
      template(v-slot:activator="{ on }")
        v-btn(color="error" v-on="on") Delete Template
      v-card
        v-card-title
          span(class="headline") Delete this Template
        v-card-text
          p.body-2 All of your content entries associated with this template will be lost.
          p.body-1 Are you sure you want to delete this template?
        v-card-actions
          v-spacer
          v-btn(@click="dialog = false") Cancel
          v-btn(color="error" @click="destroy") Delete Template

  router-link(:to="{ name: 'entities_path', params: { template_id: $route.params.template_id } }") Back
</template>

<script>
import TemplateForm from './_form.vue'
export default {
  props: ['workspace'],
  components: {
    TemplateForm
  },
  data() {
    return {
      dialog: false,
      template: null
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.template = null
      this.$store.dispatch('templates/show', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id }).then(() => {
        // this.template = this.$store.state.templates.list[this.$route.params.template_id]
        this.template = this.$store.getters['templates/findBySlug'](this.workspace.id, this.$route.params.template_id)
      })
    },
    update: function () {
      this.$store.dispatch('templates/update', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id, data: { template: this.template } }).then((res) => {
        this.$router.push({ name: 'entities_path', params: { template_id: res.slug } })
      }).catch((errors) => {
        this.template.errors = errors
      })
    },
    destroy: function () {
      this.$store.dispatch('templates/destroy', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

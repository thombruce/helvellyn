<template lang="pug">
div(v-if="template")
  h2 {{ template.plural }} Settings
  template-form(v-if="template" :workspace="workspace" :template="template", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
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

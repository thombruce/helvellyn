<template lang="pug">
div
  h2 Templates

  router-link(:to="{ name: 'new_template_path' }") New template

  v-simple-table(v-if="templates")
    thead
      tr
        th Name
        th Actions
    tbody
      tr(v-for="template in templates")
        td
          router-link(:to="{ name: 'entities_path', params: { template_id: template.slug } }") {{ template.plural }}
        td
          router-link.mr-1(:to="{ name: 'entities_path', params: { template_id: template.slug } }") View
          router-link.mr-1(:to="{ name: 'edit_template_path', params: { template_id: template.slug } }") Edit

  p.lead.text-center(v-else) No items to show.
</template>

<script>
export default {
  props: ['workspace'],
  data () {
    return {
      templates: null
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
      this.templates = null
      this.$store.dispatch('templates/index', { workspace_id: this.$route.params.workspace_id }).then(() => {
        // this.templates = this.$store.state.templates.list
        this.templates = this.$store.getters['templates/forWorkspace'](this.workspace.id)
      })
    }
  }
}
</script>

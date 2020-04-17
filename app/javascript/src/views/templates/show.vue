<template lang="pug">
div
  div(v-if="template")
    router-view(:workspace="workspace" :template="template")
</template>

<script>
export default {
  props: ['workspace'],
  data () {
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
        if (!this.template.permissions.view_template) {
          this.$router.replace({ name: 'templates_path', params: { workspace_id: this.workspace.slug } })
        }
      })
    }
  }
}
</script>

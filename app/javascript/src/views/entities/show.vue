<template lang="pug">
div(v-if="entity")
  h2 {{ template.name }}
  p(v-for="field in template.fields")
    strong {{ field.name }}
    | &nbsp;
    span {{ entity.data[field.slug] }}
  router-link(:to="{ name: 'edit_entity_path', params: { entity_id: entity.slug } }") Edit
  router-view
</template>

<script>
export default {
  props: ['workspace', 'template'],
  data () {
    return {
      entity: {
        data: {}
      }
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
      this.entity = null
      this.$store.dispatch('entities/show', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id, entity_id: this.$route.params.entity_id }).then(() => {
        // this.entity = this.$store.state.entities.list[this.$route.params.entity_id]
        this.entity = this.$store.getters['entities/findBySlug'](this.template.id, this.$route.params.entity_id)
        if (!this.entity.permissions.view_entity) {
          this.$router.replace({ name: 'templates_path', params: { workspace_id: this.workspace.slug } })
        }
      })
    }
  }
}
</script>

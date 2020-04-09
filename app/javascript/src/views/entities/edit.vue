<template lang="pug">
div(v-if="entity")
  h2 Edit {{ template.name }}
  entity-form(:template="template" :entity="entity", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'entity_path', params: { entity_id: $route.params.entity_id } }") Back
</template>

<script>
import EntityForm from './_form.vue'
export default {
  props: ['workspace', 'template'],
  components: {
    EntityForm
  },
  data() {
    return {
      entity: {
        errors: []
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
      })
    },
    update: function () {
      this.$store.dispatch('entities/update', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id, entity_id: this.$route.params.entity_id, data: { [this.template.slug]: this.entity } }).then((res) => {
        this.$router.push({ name: 'entity_path', params: { entity_id: res.slug } })
      }).catch((errors) => {
        this.entity.errors = errors
      })
    },
    destroy: function () {
      this.$store.dispatch('entities/destroy', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id, entity_id: this.$route.params.entity_id }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

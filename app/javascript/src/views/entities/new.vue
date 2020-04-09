<template lang="pug">
div(v-if="entity")
  h2 New {{ template.name }}
  entity-form(:template="template" :entity="entity" :submit="create")
  router-link(:to="{ name: 'entities_path' }") Back
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
  methods: {
    create: function () {
      this.$store.dispatch('entities/create', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id, data: { [this.template.slug]: this.entity } }).then((res) => {
        this.$router.push({ name: 'entity_path', params: { entity_id: res.slug } })
      }).catch((errors) => {
        this.entity.errors = errors
      })
    }
  }
}
</script>

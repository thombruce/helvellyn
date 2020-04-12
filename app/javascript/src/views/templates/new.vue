<template lang="pug">
div
  h2 New Template
  template-form(:workspace="workspace" :template="template" :submit="create")
  router-link(:to="{ name: 'templates_path' }") Back
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
      template: {
        name: '',
        slug: '',
        publishable: true,
        sluggable_field: '',
        sort: 'created_at',
        desc: true,
        fields: [],
        errors: []
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('templates/create', { workspace_id: this.$route.params.workspace_id, data: { template: this.template } }).then((res) => {
        this.$router.push({ name: 'entities_path', params: { template_id: res.slug } })
      }).catch((errors) => {
        console.log(errors)
        this.template.errors = errors
      })
    }
  }
}
</script>

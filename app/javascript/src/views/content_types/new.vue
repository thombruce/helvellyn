<template lang="pug">
div
  h2 New Content Type
  content-type-form(:workspace="workspace" :content_type="content_type" :submit="create")
  router-link(:to="{ name: 'content_types_path' }") Back
</template>

<script>
import ContentTypeForm from './_form.vue'
export default {
  props: ['workspace'],
  components: {
    ContentTypeForm
  },
  data() {
    return {
      content_type: {
        name: '',
        fields: []
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('content_types/create', { workspace_id: this.$route.params.workspace_id, data: { content_type: this.content_type } }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

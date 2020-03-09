<template lang="pug">
div
  h2 New Content Type
  content-type-form(:content_type="content_type" :submit="create")
  router-link(:to="{ name: 'content_types_path' }") Back
</template>

<script>
import ContentTypeForm from './_form.vue'
export default {
  components: {
    ContentTypeForm
  },
  data() {
    return {
      content_type: {
        content: ''
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('content_types/create', { workspaceId: this.$route.params.workspaceId, data: { content_type: this.content_type } }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

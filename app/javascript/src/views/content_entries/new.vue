<template lang="pug">
div
  h2 New Content Entry
  content-entry-form(:content_entry="content_entry" :submit="create")
  router-link(:to="{ name: 'content_entries_path' }") Back
</template>

<script>
import ContentEntryForm from './_form.vue'
export default {
  components: {
    ContentEntryForm
  },
  data() {
    return {
      content_entry: {
        name: '',
        fields: []
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('content_entries/create', { workspaceId: this.$route.params.workspaceId, data: { content_entry: this.content_entry } }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

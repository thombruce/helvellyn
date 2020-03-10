<template lang="pug">
div(v-if="content_entry")
  h2 New Content Entry
  content-entry-form(:content_type="content_type" :content_entry="content_entry" :submit="create")
  router-link(:to="{ name: 'content_entries_path' }") Back
</template>

<script>
import ContentEntryForm from './_form.vue'
export default {
  props: ['workspace', 'content_type'],
  components: {
    ContentEntryForm
  },
  data() {
    return {
      content_entry: {}
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('content_entries/create', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId, data: { [this.content_type.slug]: this.content_entry } }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

<template lang="pug">
div
  div(v-if="content_entry")
    h2(v-html="content_entry.name")
    p(v-html="content_entry.content")
    router-link(:to="{ name: 'edit_content_entry_path', params: { content_entryId: content_entry.slug } }") Edit
    router-view
</template>

<script>
export default {
  data () {
    return {
      content_entry: null
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
      this.content_entry = null
      this.$store.dispatch('content_entries/show', { workspaceId: this.$route.params.workspaceId, content_entryId: this.$route.params.content_entryId }).then(() => {
        this.content_entry = this.$store.state.content_entrys.list[this.$route.params.content_entryId]
      })
    }
  }
}
</script>

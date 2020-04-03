<template lang="pug">
div
  h2 All {{ content_type.plural }}

  div(v-if="content_entries")
    content-entries-table(:content_type="content_type" :content_entries="content_entries")

  p.lead.text-center(v-else) No items to show.
</template>

<script>
import ContentEntriesTable from './_table.vue'
export default {
  props: ['workspace', 'content_type'],
  components: {
    ContentEntriesTable
  },
  data () {
    return {
      content_entries: null
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
      this.content_entries = null
      this.$store.dispatch('content_entries/index', { workspace_id: this.$route.params.workspace_id, content_type_id: this.$route.params.content_type_id }).then(() => {
        // this.content_entries = this.$store.state.content_entries.list
        this.content_entries = this.$store.getters['content_entries/forContentType'](this.content_type.id)
      })
    }
  }
}
</script>

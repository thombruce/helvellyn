<template lang="pug">
div
  h2 All {{ content_type.plural }}

  div(v-if="content_entries")
    v-data-table(
      :headers="tableHeaders"
      :items="content_entries"
      :items-per-page="5"
    )
      template(v-slot:item.actions="{ item }")
        v-btn(:to="{ name: 'content_entry_path', params: { content_entry_id: item.slug } }" icon)
          v-icon(small) mdi-eye
        v-btn(:to="{ name: 'edit_content_entry_path', params: { content_entry_id: item.slug } }" icon)
          v-icon(small) mdi-pencil

  p.lead.text-center(v-else) No items to show.
</template>

<script>
export default {
  props: ['workspace', 'content_type'],
  data () {
    return {
      content_entries: null
    }
  },
  computed: {
    tableHeaders() {
      const headers = this.content_type.fields.map(field => {
        return { text: field.name, value: field.slug }
      })
      headers.push({ text: 'Actions', value: 'actions', sortable: false })
      return headers
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

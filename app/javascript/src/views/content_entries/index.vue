<template lang="pug">
div
  h2 Content Entries

  router-link(:to="{ name: 'new_content_entry_path' }") New content_entry

  table.table(v-if="content_entries")
    thead.thead-dark
      tr
        th Name
        th(v-for="field in content_type.fields") {{ field.name }}
        th Actions
    tbody
      tr(v-for="content_entry in content_entries")
        td
          router-link(:to="{ name: 'content_entry_path', params: { content_entryId: content_entry.id } }") {{ content_entry.id }}
        td(v-for="field in content_type.fields") {{ content_entry[field.slug] }}
        td
          router-link.mr-1(:to="{ name: 'content_entry_path', params: { content_entryId: content_entry.id } }") View
          router-link.mr-1(:to="{ name: 'edit_content_entry_path', params: { content_entryId: content_entry.id } }") Edit

  p.lead.text-center(v-else) No items to show.
</template>

<script>
export default {
  props: ['content_type'],
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
      this.$store.dispatch('content_entries/index', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId }).then(() => {
        this.content_entries = this.$store.state.content_entries.list
      })
    }
  }
}
</script>

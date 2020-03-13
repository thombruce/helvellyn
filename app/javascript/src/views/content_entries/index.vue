<template lang="pug">
div
  h2 All {{ content_type.name }}

  table.table(v-if="content_entries")
    thead.thead-dark
      tr
        th Name
        th(v-for="field in content_type.fields") {{ field.name }}
        th Actions
    tbody
      tr(v-for="content_entry in content_entries")
        td
          router-link(:to="{ name: 'content_entry_path', params: { content_entry_id: content_entry.slug } }") {{ content_entry.id }}
        td(v-for="field in content_type.fields") {{ content_entry[field.slug] }}
        td
          router-link.mr-1(:to="{ name: 'content_entry_path', params: { content_entry_id: content_entry.slug } }") View
          router-link.mr-1(:to="{ name: 'edit_content_entry_path', params: { content_entry_id: content_entry.slug } }") Edit

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
        this.content_entries = this.$store.state.content_entries.list
      })
    }
  }
}
</script>

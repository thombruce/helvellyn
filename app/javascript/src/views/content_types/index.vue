<template lang="pug">
div
  h2 Content Types

  router-link(:to="{ name: 'new_content_type_path' }") New content_type

  v-simple-table(v-if="content_types")
    thead
      tr
        th Name
        th Actions
    tbody
      tr(v-for="content_type in content_types")
        td
          router-link(:to="{ name: 'content_entries_path', params: { content_type_id: content_type.slug } }") {{ content_type.id }}
        td
          router-link.mr-1(:to="{ name: 'content_entries_path', params: { content_type_id: content_type.slug } }") View
          router-link.mr-1(:to="{ name: 'edit_content_type_path', params: { content_type_id: content_type.slug } }") Edit

  p.lead.text-center(v-else) No items to show.
</template>

<script>
export default {
  data () {
    return {
      content_types: null
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
      this.content_types = null
      this.$store.dispatch('content_types/index', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.content_types = this.$store.state.content_types.list
      })
    }
  }
}
</script>

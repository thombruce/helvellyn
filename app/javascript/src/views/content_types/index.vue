<template lang="pug">
div
  h2 Content Types

  router-link(:to="{ name: 'new_content_type_path' }") New content_type

  table.table(v-if="content_types")
    thead.thead-dark
      tr
        th Name
        th Actions
    tbody
      tr(v-for="content_type in content_types")
        td
          router-link(:to="{ name: 'content_type_path', params: { content_typeId: content_type.id } }") {{ content_type.id }}
        td
          router-link.mr-1(:to="{ name: 'content_type_path', params: { content_typeId: content_type.id } }") View
          router-link.mr-1(:to="{ name: 'edit_content_type_path', params: { content_typeId: content_type.id } }") Edit

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
      this.$store.dispatch('content_types/index', { workspaceId: this.$route.params.workspaceId }).then(() => {
        this.content_types = this.$store.state.content_types.list
      })
    }
  }
}
</script>

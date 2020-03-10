<template lang="pug">
div(v-if="content_entry")
  p(v-for="field in content_type.fields")
    strong {{ field.name }}
    | &nbsp;
    span {{ content_entry[field.slug] }}
  router-link(:to="{ name: 'edit_content_entry_path', params: { content_entryId: content_entry.id } }") Edit
  router-view
</template>

<script>
export default {
  props: ['workspace', 'content_type'],
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
      this.$store.dispatch('content_entries/show', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId, content_entryId: this.$route.params.content_entryId }).then(() => {
        this.content_entry = this.$store.state.content_entries.list[this.$route.params.content_entryId]
      })
    }
  }
}
</script>

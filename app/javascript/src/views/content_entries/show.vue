<template lang="pug">
div(v-if="content_entry")
  h2 {{ content_type.name }}
  p(v-for="field in content_type.fields")
    strong {{ field.name }}
    | &nbsp;
    span {{ content_entry[field.slug] }}
  router-link(:to="{ name: 'edit_content_entry_path', params: { content_entry_id: content_entry.slug } }") Edit
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
      this.$store.dispatch('content_entries/show', { workspace_id: this.$route.params.workspace_id, content_type_id: this.$route.params.content_type_id, content_entry_id: this.$route.params.content_entry_id }).then(() => {
        // this.content_entry = this.$store.state.content_entries.list[this.$route.params.content_entry_id]
        this.content_entry = this.$store.getters['content_entries/findBySlug'](this.content_type.id, this.$route.params.content_entry_id)
      })
    }
  }
}
</script>

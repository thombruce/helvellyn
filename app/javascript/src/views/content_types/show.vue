<template lang="pug">
div
  div(v-if="content_type")
    h2(v-html="content_type.name")
    p(v-html="content_type.content")
    router-link(:to="{ name: 'edit_content_type_path', params: { content_typeId: content_type.slug } }") Edit
</template>

<script>
export default {
  data () {
    return {
      content_type: null
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
      this.content_type = null
      this.$store.dispatch('content_types/show', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId }).then(() => {
        this.content_type = this.$store.state.content_types.list[this.$route.params.content_typeId]
      })
    }
  }
}
</script>

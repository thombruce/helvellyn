<template lang="pug">
div
  div(v-if="content_type")
    router-view(:workspace="workspace" :content_type="content_type")
</template>

<script>
export default {
  props: ['workspace'],
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
      this.$store.dispatch('content_types/show', { workspace_id: this.$route.params.workspace_id, content_type_id: this.$route.params.content_type_id }).then(() => {
        // this.content_type = this.$store.state.content_types.list[this.$route.params.content_type_id]
        this.content_type = this.$store.getters['content_types/findBySlug'](this.workspace.id, this.$route.params.content_type_id)
      })
    }
  }
}
</script>

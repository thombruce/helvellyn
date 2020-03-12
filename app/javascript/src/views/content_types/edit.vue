<template lang="pug">
div(v-if="content_type")
  h2 Edit Content Type
  content-type-form(v-if="content_type" :workspace="workspace" :content_type="content_type", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'content_entries_path', params: { content_type_id: content_type.slug } }") Back
</template>

<script>
import ContentTypeForm from './_form.vue'
export default {
  props: ['workspace'],
  components: {
    ContentTypeForm
  },
  data() {
    return {
      content_type: {
        name: ''
      }
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
        this.content_type = this.$store.state.content_types.list[this.$route.params.content_type_id]
      })
    },
    update: function () {
      this.$store.dispatch('content_types/update', { workspace_id: this.$route.params.workspace_id, content_type_id: this.content_type.id, data: { content_type: this.content_type } }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('content_types/destroy', { workspace_id: this.$route.params.workspace_id, content_type_id: this.content_type.id }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

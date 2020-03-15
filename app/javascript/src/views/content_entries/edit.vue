<template lang="pug">
div(v-if="content_entry")
  h2 Edit {{ content_type.name }}
  content-entry-form(:content_type="content_type" :content_entry="content_entry", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'content_entry_path', params: { content_entry_id: $route.params.content_entry_id } }") Back
</template>

<script>
import ContentEntryForm from './_form.vue'
export default {
  props: ['workspace', 'content_type'],
  components: {
    ContentEntryForm
  },
  data() {
    return {
      content_entry: {
        errors: []
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
      this.content_entry = null
      this.$store.dispatch('content_entries/show', { workspace_id: this.$route.params.workspace_id, content_type_id: this.$route.params.content_type_id, content_entry_id: this.$route.params.content_entry_id }).then(() => {
        // this.content_entry = this.$store.state.content_entries.list[this.$route.params.content_entry_id]
        this.content_entry = this.$store.getters['content_entries/findBySlug'](this.content_type.id, this.$route.params.content_entry_id)
      })
    },
    update: function () {
      this.$store.dispatch('content_entries/update', { workspace_id: this.$route.params.workspace_id, content_type_id: this.$route.params.content_type_id, content_entry_id: this.$route.params.content_entry_id, data: { [this.content_type.slug]: this.content_entry } }).then((res) => {
        this.$router.push({ name: 'content_entry_path', params: { content_entry_id: res.slug } })
      }).catch((errors) => {
        this.content_entry.errors = errors
      })
    },
    destroy: function () {
      this.$store.dispatch('content_entries/destroy', { workspace_id: this.$route.params.workspace_id, content_type_id: this.$route.params.content_type_id, content_entry_id: this.$route.params.content_entry_id }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

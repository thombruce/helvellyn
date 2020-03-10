<template lang="pug">
div
  h2 Edit Content Entry
  content-entry-form(v-if="content_entry" :content_type="content_type" :content_entry="content_entry", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'content_entry_path', params: { content_entryId: content_entry.id } }") Back
</template>

<script>
import ContentEntryForm from './_form.vue'
export default {
  props: ['content_type'],
  components: {
    ContentEntryForm
  },
  data() {
    return {
      content_entry: {
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
      this.content_entry = null
      this.$store.dispatch('content_entries/show', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId, content_entryId: this.$route.params.content_entryId }).then(() => {
        this.content_entry = this.$store.state.content_entries.list[this.$route.params.content_entryId]
      })
    },
    update: function () {
      this.$store.dispatch('content_entries/update', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId, content_entryId: this.content_entry.id, data: { [this.content_type.slug]: this.content_entry } }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('content_entries/destroy', { workspaceId: this.$route.params.workspaceId, content_typeId: this.$route.params.content_typeId, content_entryId: this.content_entry.id }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

<template lang="pug">
div
  h2 Edit Content Type
  content-type-form(v-if="content_type" :content_type="content_type", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'content_type_path' }") Back
</template>

<script>
import ContentTypeForm from './_form.vue'
export default {
  components: {
    ContentTypeForm
  },
  data() {
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
      this.$store.dispatch('content_types/show', this.$route.params.content_typeId).then(() => {
        this.content_type = this.$store.state.content_types.list[this.$route.params.content_typeId]
      })
    },
    update: function () {
      this.$store.dispatch('content_types/update', { id: this.content_type.id, content_type: this.content_type }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('content_types/destroy', this.content_type.id).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>

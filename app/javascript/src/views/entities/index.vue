<template lang="pug">
div
  h2 All {{ template.plural }}

  div(v-if="entities")
    entities-table(:template="template" :entities="entities")

  p.lead.text-center(v-else) No items to show.
</template>

<script>
import EntitiesTable from './_table.vue'
export default {
  props: ['workspace', 'template'],
  components: {
    EntitiesTable
  },
  data () {
    return {
      entities: null
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
      this.entities = null
      this.$store.dispatch('entities/index', { workspace_id: this.$route.params.workspace_id, template_id: this.$route.params.template_id }).then(() => {
        // this.entities = this.$store.state.entities.list
        this.entities = this.$store.getters['entities/forTemplate'](this.template.id)
      })
    }
  }
}
</script>

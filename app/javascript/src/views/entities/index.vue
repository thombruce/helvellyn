<template lang="pug">
div
  h2 All {{ template.plural }}

  div(v-if="entities")
    v-data-table(
      :headers="tableHeaders"
      :items="entities"
      :options.sync="options"
      :server-items-length="template.entities_count"
      :footer-props="footerOptions"
    )
      template(v-slot:item.created_at="{ item }")
        span {{ new Date(item.created_at).toLocaleDateString() }}
      template(v-slot:item.updated_at="{ item }")
        span {{ new Date(item.updated_at).toLocaleDateString() }}
      template(v-slot:item.published_at="{ item }")
        span {{ item.published ? new Date(item.published_at).toLocaleDateString() : '' }}
      template(v-slot:item.actions="{ item }")
        v-btn(:to="{ name: 'entity_path', params: { entity_id: item.slug } }" icon)
          v-icon(small) mdi-eye
        v-btn(:to="{ name: 'edit_entity_path', params: { entity_id: item.slug } }" icon)
          v-icon(small) mdi-pencil

</template>

<script>
export default {
  props: ['workspace', 'template'],
  data () {
    return {
      entities: null,
      options: {
        page: parseInt(this.$route.query.page || 1),
        itemsPerPage: this.$route.query.per || 25,
        sortBy: [this.$route.query.sort] || null,
        sortDesc: this.$route.query.desc ? [(this.$route.query.desc == 'true')] : null
      },
      footerOptions: {
        'items-per-page-options': [5,10,15,20,25],
        'show-current-page': true,
        'show-first-last-page': true
      }
    }
  },
  computed: {
    tableHeaders() {
      return [
        { text: this.template.fields[0].name, value: this.template.fields[0].slug, sortable: false },
        { text: 'Created', value: 'created_at' },
        { text: 'Updated', value: 'updated_at' },
        { text: 'Published', value: 'published_at' },
        { text: 'Actions', value: 'actions', sortable: false }
      ]
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData',
    options: {
      handler () {
        this.fetchData()
      },
      deep: true
    },
  },
  methods: {
    fetchData () {
      let query = {
        page: this.options.page,
        per: this.options.itemsPerPage,
        sort: (this.options.sortBy ? this.options.sortBy[0] : null),
        desc: (this.options.sortDesc ? this.options.sortDesc[0] : null)
      }
      this.$store.dispatch(
        'entities/index',
        {
          workspace_id: this.$route.params.workspace_id,
          template_id: this.$route.params.template_id,
          query
        }
      ).then((data) => {
        this.entities = data
      })
    }
  }
}
</script>

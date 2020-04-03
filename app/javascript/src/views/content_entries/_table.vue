<template lang="pug">
v-data-table(
  :headers="tableHeaders"
  :items="content_entries"
  :items-per-page="5"
)
  template(v-slot:item.actions="{ item }")
    v-btn(:to="{ name: 'content_entry_path', params: { content_entry_id: item.slug } }" icon)
      v-icon(small) mdi-eye
    v-btn(:to="{ name: 'edit_content_entry_path', params: { content_entry_id: item.slug } }" icon)
      v-icon(small) mdi-pencil
</template>

<script>
export default {
  props: ['content_type', 'content_entries'],
  computed: {
    tableHeaders() {
      let headers = this.content_type.fields.map(field => {
        return { text: field.name, value: field.slug }
      })
      headers.push({ text: 'Actions', value: 'actions', sortable: false })
      return headers
    }
  }
}

// TODO: https://vuetifyjs.com/en/components/data-tables/#paginate-and-sort-server-side
</script>

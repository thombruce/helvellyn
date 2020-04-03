<template lang="pug">
v-data-table(
  :headers="tableHeaders"
  :items="content_entries"
  :items-per-page="5"
)
  template(v-slot:item.created_at="{ item }")
    span {{ new Date(item.created_at).toLocaleDateString() }}
  template(v-slot:item.updated_at="{ item }")
    span {{ new Date(item.updated_at).toLocaleDateString() }}
  template(v-slot:item.published_at="{ item }")
    span {{ item.published ? new Date(item.published_at).toLocaleDateString() : '' }}
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
      return [
        { text: this.content_type.fields[0].name, value: this.content_type.fields[0].slug },
        { text: 'Created', value: 'created_at' },
        { text: 'Updated', value: 'updated_at' },
        { text: 'Published', value: 'published_at' },
        { text: 'Actions', value: 'actions', sortable: false }
      ]
    }
    // NOTE: Below works to show all fields, but fields can't be filtered in place
    //       to, for example, truncate long content fields... Might be a good case
    //       for expandable forms, actually. A feature of these tables.
    // TODO: Look into expandable items as an option.
    //
    // tableHeaders() {
    //   let headers = this.content_type.fields.map(field => {
    //     return { text: field.name, value: field.slug }
    //   })
    //   headers.push({ text: 'Actions', value: 'actions', sortable: false })
    //   return headers
    // }
  }
}

// TODO: https://vuetifyjs.com/en/components/data-tables/#paginate-and-sort-server-side
</script>

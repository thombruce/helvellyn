<template lang="pug">
v-list
  v-list-item
    v-list-item-title {{ workspace.title }}
  v-list-group(v-for="content_type in workspace.content_types" prepend-icon="mdi-file")
    template(v-slot:activator)
      v-list-item-title {{ content_type.name }}
    v-list-item(link :to="{ name: 'content_entries_path', params: { content_type_id: content_type.slug } }")
      v-list-item-content All
      v-list-item-icon
        v-icon mdi-file
    v-list-item(link :to="{ name: 'new_content_entry_path', params: { content_type_id: content_type.slug } }")
      v-list-item-content New
      v-list-item-icon
        v-icon mdi-plus
    v-list-item(link :to="{ name: 'edit_content_type_path', params: { content_type_id: content_type.slug } }")
      v-list-item-content Settings
      v-list-item-icon
        v-icon mdi-settings
  v-list-item(link :to="{ name: 'new_content_type_path' }")
    v-list-item-icon
      v-icon mdi-plus
    v-list-item-content New Type
</template>

<script>
export default {
  props: [
    'workspace'
  ]
}
</script>

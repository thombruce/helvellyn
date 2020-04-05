<template lang="pug">
v-list
  v-list-item(link :to="{ name: 'content_types_path', params: { workspace_id: workspace.slug } }" exact)
    v-list-item-title {{ workspace.title }}
  content-type-list-group(v-for="content_type in workspace.content_types" :content_type="content_type")
  v-list-item(link :to="{ name: 'new_content_type_path' }")
    v-list-item-icon
      v-icon mdi-plus
    v-list-item-content New Type
  v-list-item(to="#")
    v-list-item-icon
      v-icon mdi-account-multiple
    v-list-item-content Users
  v-list-item(:to="{ name: 'edit_workspace_path', params: { workspace_id: workspace.slug } }")
    v-list-item-icon
      v-icon mdi-settings
    v-list-item-content Settings
</template>

<script>
import ContentTypeListGroup from './_contentTypeListGroup.vue'

export default {
  props: [
    'workspace'
  ],
  components: {
    ContentTypeListGroup
  }
}
</script>

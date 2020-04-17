<template lang="pug">
v-list
  v-list-item(link :to="{ name: 'templates_path', params: { workspace_id: workspace.slug } }" exact)
    v-list-item-title {{ workspace.title }}
  template-list-group(v-for="template in workspace.templates" :template="template")
  v-list-item(
    v-if="workspace.permissions.create_templates"
    link
    :to="{ name: 'new_template_path' }"
  )
    v-list-item-icon
      v-icon mdi-plus
    v-list-item-content New Type
  v-list-item(:to="{ name: 'users_path', params: { workspace_id: workspace.slug } }")
    v-list-item-icon
      v-icon mdi-account-multiple
    v-list-item-content Users
  v-list-item(
    v-if="workspace.permissions.update_workspace"
    :to="{ name: 'edit_workspace_path', params: { workspace_id: workspace.slug } }"
  )
    v-list-item-icon
      v-icon mdi-settings
    v-list-item-content Settings
</template>

<script>
import TemplateListGroup from './_templateListGroup.vue'

export default {
  props: [
    'workspace'
  ],
  components: {
    TemplateListGroup
  }
}
</script>

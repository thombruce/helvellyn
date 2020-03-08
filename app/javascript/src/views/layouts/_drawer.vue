<template lang="pug">
v-navigation-drawer(v-model="drawer" app temporary)
  v-list-item(v-if="currentWorkspace")
    v-list-item-content
      v-list-item-title {{ currentWorkspace.title }}
      v-list-item-subtitle subtext
  v-list(v-if="workspaces")
    v-list-item(v-for="workspace in workspaces" link :to="{ name: 'workspace_path', params: { workspaceId: workspace.id } }") {{ workspace.title }}
    v-list-item(link :to="{ name: 'new_workspace_path' }") New Workspace
    template(v-if="currentWorkspace")
      v-list-item(link :to="{ name: 'posts_path' }") All
      v-list-item(link :to="{ name: 'new_post_path' }") New Post
      v-list-item(link :to="{ name: 'posts_path' }") New +
  template(v-slot:append)
    .pa-2
      v-btn(block :to="{ name: 'user_path', params: { userId: currentUser.id } }") Account
</template>

<script>
import Workspaces from '../../mixins/workspaces.js'
export default {
  props: ['drawer'],
  mixins: [
    Workspaces
  ]
}
</script>
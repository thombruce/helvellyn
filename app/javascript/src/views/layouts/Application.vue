<template lang="pug">
v-app(dark)
  v-navigation-drawer(
    v-model="drawer"
    clipped
    fixed
    app
  )
    workspace-nav(v-if="currentWorkspace" :workspace="currentWorkspace")
    v-list(v-else-if="workspaces")
      v-list-item(v-for="workspace in workspaces" link :to="{ name: 'content_types_path', params: { workspace_id: workspace.slug } }") {{ workspace.title }}
      v-list-item(link :to="{ name: 'new_workspace_path' }")
        v-list-item-content New Workspace
        v-list-item-icon
          v-icon mdi-plus
    template(v-slot:append)
      .pa-2
        v-btn(block :to="{ name: 'user_path', params: { user_id: currentUser.id } }") Account
  v-app-bar(clipped-left fixed app)
    v-app-bar-nav-icon(@click.stop="drawer = !drawer")
    v-btn(:to="{ name: 'root_path' }" text)
      v-toolbar-title Helvellyn
  v-content
    v-container
      slot
    v-footer
      span &copy; {{ new Date().getFullYear() }} Thom Bruce
</template>

<script>
import Workspaces from '../../mixins/workspaces.js'

import WorkspaceNav from '../workspaces/_nav.vue'

export default {
  mixins: [
    Workspaces
  ],
  components: {
    WorkspaceNav
  },
  data() {
    return {
      drawer: null // [1]
    }
  }
}

// [1] Using null as the starting value for its v-model will initialize the drawer as closed on mobile and as open on desktop.
//     https://vuetifyjs.com/en/components/navigation-drawers/#usage
</script>
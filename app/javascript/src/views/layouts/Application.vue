<template lang="pug">
v-app(dark)
  v-navigation-drawer(
    v-model="drawer"
    clipped
    fixed
    app
  )
    v-list-item(v-if="currentWorkspace")
      v-list-item-content
        v-list-item-title {{ currentWorkspace.title }}
        v-list-item-subtitle subtext
    v-list(v-if="workspaces")
      v-list-item(v-for="workspace in workspaces" link :to="{ name: 'content_types_path', params: { workspace_id: workspace.slug } }") {{ workspace.title }}
      v-list-item(link :to="{ name: 'new_workspace_path' }") New Workspace
    template(v-slot:append)
      .pa-2
        v-btn(block :to="{ name: 'user_path', params: { user_id: currentUser.id } }") Account
  v-app-bar(clipped-left fixed app)
    v-app-bar-nav-icon(@click.stop="drawer = !drawer")
    v-btn(:to="{ name: 'root_path' }" text="true")
      v-toolbar-title Helvellyn
  v-content
    v-container
      slot
    v-footer
      span &copy; {{ new Date().getFullYear() }} Thom Bruce
</template>

<script>
import Workspaces from '../../mixins/workspaces.js'

export default {
  mixins: [
    Workspaces
  ],
  data() {
    return {
      drawer: null // [1]
    }
  }
}

// [1] Using null as the starting value for its v-model will initialize the drawer as closed on mobile and as open on desktop.
//     https://vuetifyjs.com/en/components/navigation-drawers/#usage
</script>
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
    v-list-item(link :to="{ name: 'user_path', params: { userId: currentUser.id } }") Account
  template(v-slot:append)
    div.pa-2
      v-btn(block @click="signOut") Logout
</template>

<script>
import Session from '../../mixins/session.js'
import Workspaces from '../../mixins/workspaces.js'
export default {
  props: ['drawer'],
  mixins: [
    Session,
    Workspaces
  ],
  methods: {
    signOut: function () {
      this.$store.dispatch('sessions/destroy').then(() => {
        this.$router.push('/sessions/new')
      })
    }
  }
}
</script>
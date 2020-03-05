<template lang="pug">
header.navbar.navbar-expand-lg.navbar-dark.bg-primary
  strong
    router-link.navbar-brand(:to="{ name: 'root_path' }") CMS by Thom
  nav.collapse.navbar-collapse
    ul.navbar-nav(v-if="currentUser")
      li.nav-item.dropdown
        a#navbarWorkspaceDropdown.nav-link.dropdown-toggle(href='#' role='button' data-toggle='dropdown' aria-haspopup=true aria-expanded='false')
          template(v-if="currentWorkspace")
            | {{ currentWorkspace.title }}
          template(v-else)
            | Workspaces
        .dropdown-menu.dropdown-menu-left(aria-leballedBy='navbarWorkspaceDropdown')
          template(v-if="workspaces")
            router-link.dropdown-item(v-for="workspace in workspaces" :to="{ name: 'workspace_path', params: { workspaceId: workspace.id } }") {{ workspace.title }}
            .dropdown-divider
          router-link.dropdown-item(:to="{ name: 'new_workspace_path' }") New Workspace
    ul.navbar-nav.ml-auto
      li.nav-item.dropdown(v-if="currentUser")
        a#navbarUserDropdown.nav-link.dropdown-toggle(href='#' role='button' data-toggle='dropdown' aria-haspopup=true aria-expanded='false')
          | {{ currentUser.name }}
        .dropdown-menu.dropdown-menu-right(aria-leballedBy='navbarUserDropdown')
          router-link.dropdown-item(:to="{ name: 'user_path', params: { userId: currentUser.id } }") Account
          a.dropdown-item(v-on:click.stop="signOut" href="javascript:;") Sign out
      template(v-else)
        li.nav-item
          router-link.nav-link(:to="{ name: 'new_session_path' }") Sign in
        li.nav-item
          router-link.nav-link(:to="{ name: 'new_user_path' }") Sign up
</template>

<script>
import Session from '../../mixins/session.js'
import Workspaces from '../../mixins/workspaces.js'
export default {
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

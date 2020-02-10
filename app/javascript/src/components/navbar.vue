<template lang="pug">
header.navbar.fixed-top.navbar-expand-lg.navbar-dark.bg-primary
  strong
    router-link.navbar-brand(:to="{ name: 'root_path' }") Dashboard by Thom
  nav.collapse.navbar-collapse
    ul.navbar-nav.ml-auto
      li.nav-item.dropdown(v-if="currentUser")
        a#navbarUserDropdown.nav-link.dropdown-toggle(href='#' role='button' data-toggle='dropdown' aria-haspopup=true aria-expanded='false')
          | {{ currentUser.name }}
        .dropdown-menu.dropdown-menu-right(aria-leballedBy='navbarUserDropdown')
          router-link.dropdown-item(:to="{ name: 'user_path', params: { id: currentUser.id } }") Account
          a.dropdown-item(v-on:click.stop="signOut" href="javascript:;") Sign out
      template(v-else)
        li.nav-item
          router-link.nav-link(:to="{ name: 'new_session_path' }") Sign in
        li.nav-item
          router-link.nav-link(:to="{ name: 'new_user_path' }") Sign up
</template>

<script>
import Session from '../mixins/session.js'
export default {
  mixins: [Session],
  methods: {
    signOut: function () {
      this.$store.dispatch('sessions/destroy').then(() => {
        this.$router.push('/sessions/new')
      })
    }
  }
}
</script>

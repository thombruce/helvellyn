<template lang="pug">
header.navbar.fixed-top.navbar-expand-lg.navbar-dark.bg-primary
  strong
    router-link.navbar-brand(:to="{ name: 'root_path' }") Dashboard by Thom
  nav.collapse.navbar-collapse
    ul.navbar-nav.ml-auto
      li.nav-item.dropdown
        a#navbarUserDropdown.nav-link.dropdown-toggle(href='#' role='button' data-toggle='dropdown' aria-haspopup=true aria-expanded='false')
          | User
        .dropdown-menu.dropdown-menu-right(aria-leballedBy='navbarUserDropdown')
          router-link.dropdown-item(:to="{ name: 'new_session_path' }") Account
          router-link.dropdown-item(:to="{ name: 'new_session_path' }") Sign out
</template>

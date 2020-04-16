<template lang="pug">
div
  v-card(outlined)
    v-card-title Helvellyn
    v-card-subtitle
      span.subtitle-1
        strong Version
        |
        | {{ $store.getters.appVersion }}
    v-card-text
      p Thank you for using Helvellyn CMS.

  v-form(v-if="settings" ref="form" :model="settings" @submit.prevent="update")
    v-text-field(label="Name" v-model="settings.name" :error-messages="settings.errors.name" hint="The name of your installation that will appear in the top left of every page")

    v-text-field(label="Hostname" v-model="settings.hostname" :error-messages="settings.errors.hostname" hint="E.g. example.com")

    v-text-field(label="Email" v-model="settings.email" :error-messages="settings.errors.email" hint="This is the email address that users will receive their welcome email from")

    v-btn(color="primary" type="submit") Save
</template>

<script>
export default {
  data () {
    return {
      editable_settings: null
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.$store.dispatch('settings/show').then(() => {
        this.editable_settings = this.$store.state.settings.list
      })
    },
    update: function () {
      this.$store.dispatch('settings/update', { data: { settings: this.settings } }).then((res) => {
        this.$router.push({ name: 'root_path' })
      }).catch((errors) => {
        this.settings.errors = errors
      })
    }
  }
}
</script>

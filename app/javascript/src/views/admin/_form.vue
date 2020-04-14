<template lang="pug">
v-form(ref="form" :model="settings" @submit.prevent="update")
  v-text-field(label="Name" v-model="settings.name" :error-messages="settings.errors.name" hint="The name of your installation that will appear in the top left of every page")

  v-btn(color="primary" type="submit") Save
</template>

<script>
export default {
  props: [
    'settings',
    'submit'
  ],
  computed: {
    baseUrl() {
      return window.location.host + "/" // NOTE: Fine for web app; may need reconsideration for native app support.
    }
  },
  methods: {
    update: function () {
      this.$store.dispatch('settings/update', { data: { settings: this.settings } }).then((res) => {
        this.$router.push({ name: 'root_path' })
      }).catch((errors) => {
        this.settings.errors = errors
      })
    },
  }
}
</script>

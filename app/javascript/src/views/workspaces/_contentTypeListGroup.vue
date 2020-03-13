<template lang="pug">
v-list-group(prepend-icon="mdi-file" :value="isCurrent")
  template(v-slot:activator)
    v-list-item-title {{ content_type.plural }}
  v-list-item(link :to="{ name: 'content_entries_path', params: { content_type_id: content_type.slug } }" exact)
    v-list-item-content All {{ content_type.plural }}
    v-list-item-icon
      v-icon mdi-file
  v-list-item(link :to="{ name: 'new_content_entry_path', params: { content_type_id: content_type.slug } }" exact)
    v-list-item-content New {{ content_type.name }}
    v-list-item-icon
      v-icon mdi-plus
  v-list-item(link :to="{ name: 'edit_content_type_path', params: { content_type_id: content_type.slug } }" exact)
    v-list-item-content {{ content_type.plural }} Settings
    v-list-item-icon
      v-icon mdi-settings
</template>

<script>
export default {
  props: ['content_type'],
  computed: {
    isCurrent () {
      return this.$route.params.content_type_id === this.content_type.slug
    }
  }
}
</script>
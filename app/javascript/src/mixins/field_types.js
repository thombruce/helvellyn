const field_types = {
  data() {
    return {
      field_types: [
        {
          text: 'Short Text',
          value: 'String',
          icon: 'mdi-text-short'
        },
        {
          text: 'Long Text',
          value: 'Text',
          icon: 'mdi-text-subject'
        },
        {
          text: 'Rich Text',
          value: 'Rich Text',
          icon: 'mdi-format-pilcrow'
        },
        {
          text: 'Markdown',
          value: 'Markdown',
          icon: 'mdi-markdown'
        }
      ]
    }
  }
}

export default field_types

// TODO: Additional types:
//       - tags, but how to make these queryable accross content_entries (as additional content_type, maybe?)
//       - single selects (categories?? again: do we make these queryable across content_entries?)
//       - multi-selects (somewhat related to tags, above)
//       - numbers: integers, decimals <- definitely usable for sorting
//       - date and time <- will, for sure, be queryable across entries, and sortable - might be a good starter to see how that might work

// TODO: Advanced types:
//       - Location might be cool; select by search or map-pin, store GPS coordinates
//       - Weather ?? Maybe something for outside-integrations

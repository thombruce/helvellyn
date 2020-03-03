const blogs = {
  data () {
    return {
      blogs: null
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
      this.blogs = null
      this.$store.dispatch('blogs/index').then(() => {
        this.blogs = this.$store.state.blogs.list
      })
    }
  }
}

export default blogs

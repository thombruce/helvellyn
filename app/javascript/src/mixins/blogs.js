const blogs = {
  data () {
    return {
      blogs: null
    }
  },
  computed: {
    currentBlog () {
      return this.$store.state.blogs.list[this.$route.params.blogId]
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    $route(to, from) {
      this.fetchData()
    }
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

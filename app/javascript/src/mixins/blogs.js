const blogs = {
  data () {
    return {
      blogs: null,
      currentBlog: null
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
        this.currentBlog = this.blogs[this.$route.params.blogId]
      })
    }
  }
}

export default blogs

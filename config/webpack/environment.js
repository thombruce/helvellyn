const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const pug = require('./loaders/pug')
// const scss = require('./loaders/scss') // [1]
const fs = require('fs')
const packageJson = fs.readFileSync('./package.json')
const version = JSON.parse(packageJson).version || 0

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.plugins.prepend(
  'Define',
  new webpack.DefinePlugin({
    'process.env': {
        PACKAGE_VERSION: '"' + version + '"'
    }
  })
)

environment.loaders.prepend('vue', vue)
environment.loaders.prepend('pug', pug)
// environment.loaders.prepend('scss', scss) // [1]

const resolver = {
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  }
}
environment.config.merge(resolver)

module.exports = environment

// [1] Removed custom SCSS loader as it appears to conflict with Vuetify.
//     I believe it was originally added when using Bootstrap to template,
//     and was required to compile SCSS to CSS. Best guess: Vuetify now
//     handles that for us, and our loader conflicts with it.

const { environment } = require('@rails/webpacker')

// Avoid transpiling the node_modules folder with the babel-loader (mapbox-gl issues)
// https://github.com/rails/webpacker/blob/54c3ca9245e9ee330f8ca63b447c202290f7b624/docs/v4-upgrade.md#excluding-node_modules-from-being-transpiled-by-babel-loader
environment.loaders.delete('nodeModules')

module.exports = environment

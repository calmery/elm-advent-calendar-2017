const path = require( 'path' )

const webpack = require( 'webpack' )
const merge = require( 'webpack-merge' )
const CopyWebpackPlugin = require( 'copy-webpack-plugin' )

const resolve = filePath => path.resolve( __dirname, filePath )

const common = {
  devtool: 'source-map',
  resolve: {
    extensions: ['.js']
  },
  externals: ['electron'],
  output: {
    libraryTarget: 'commonjs2'
  }
}

const backend = {
  entry: resolve( 'src/entry.js' ),
  output: {
    path: resolve( 'dist' ),
    filename: 'index.js'
  },
  node: {
    __dirname: false,
  },
  plugins: [
    new CopyWebpackPlugin( [
      { from: resolve( 'package.json' ), to: resolve( 'dist/package.json' ) },
    ] )
  ],
  target: 'node'
}

const frontend = {
  entry: resolve( 'src/public/entry.js' ),
  module: {
    rules: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      use: {
        loader: 'elm-webpack-loader',
        options: {
          verbose: true,
          warn: true
        }
      }
    }, {
      test: /\.html$/,
      exclude: /node_modules/,
      use: {
        loader: 'file-loader',
        options: {
          name: '[name].[ext]'
        }
      }
    }, {
      test: /\.css$/,
      loaders: [ 'style-loader', 'css-loader']
    }]
  },
  output: {
    path: resolve( './dist/public/' ),
    filename: 'app.js'
  }
}

module.exports = [
  merge( common, backend ),
  merge( common, frontend )
]

// Example webpack configuration with asset fingerprinting in production.
"use strict";

var path = require("path");
var webpack = require("webpack");
var StatsPlugin = require("stats-webpack-plugin");

// must match config.webpack.dev_server.port
var devServerPort = 3808;

// set TARGET=production on the environment to add asset fingerprints
var production = process.env.TARGET === "production";

var config = {
  entry: {
    // Sources are expected to live in $app_root/webpack
    "application": "./webpack/javascripts/application.js"
  },

  externals: {
    foundation: "Foundation",
    app: "App"
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, "..", "public", "webpack"),
    publicPath: path.join(JSON.stringify(process.env.ASSET_HOST) || "", "webpack"),

    filename: production ? "[name]-[chunkhash].js" : "[name].js"
  },

  resolve: {
    root: path.join(__dirname, "..", "webpack", "javascripts"),
    extensions: [ "", ".js", ".jsx" ]
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        loaders: ["babel-loader"],
        exclude: /node_modules/
      },
      {
        test: /\.jsx$/,
        loaders: [ "babel-loader" ]
      },
    ]
  },

  plugins: [
    // must match config.webpack.manifest_filename
    new StatsPlugin("manifest.json", {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    }),

    new webpack.DefinePlugin({
      "process.env": { NODE_ENV: JSON.stringify("production"), HOST: JSON.stringify(process.env.HOST) }
    }),
  ]
};

if (production) {
  config.plugins.push(
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
  );
} else {
  config.devServer = {
    port: devServerPort,
    headers: { "Access-Control-Allow-Origin": "*" }
  };
  config.output.publicPath = "//localhost:" + devServerPort + "/webpack/";
  // Source maps
  config.devtool = "cheap-module-eval-source-map";
}

module.exports = config;

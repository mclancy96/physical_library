const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
  entry: './app/javascript/packs/application.js', // Adjust the entry point as needed
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'public/packs'), // Adjust the output path as needed
    publicPath: '/packs/',
  },
  mode: process.env.NODE_ENV || 'development',
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            cacheDirectory: true,
          },
        },
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
        ],
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader',
        ],
      },
      {
        test: /\.(png|jpg|gif|svg|ico)$/, // Add more file types if needed
        type: 'asset/resource', // Updated for Webpack 5
      },
      {
        test: /\.json$/,
        type: 'json', // Ensures that JSON files are handled correctly
      },
    ],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new MiniCssExtractPlugin({
      filename: '[name].css',
    }),
  ],
  resolve: {
    extensions: ['.js', '.jsx', '.css', '.scss'], // Add other extensions as needed
  },
  devtool: 'source-map', // Optional for debugging

};
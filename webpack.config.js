const path = require("path");
const webpack = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");

module.exports = (env, argv) => {
  const isProduction = argv.mode === "production";

  return {
    mode: isProduction ? "production" : "development",
    entry: {
      application: "./app/javascript/packs/application.js"
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "public/packs"),
      publicPath: "/packs/"
    },
    resolve: {
      extensions: [".js", ".jsx", ".scss", ".css"]
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader",
            options: {
              presets: ["@babel/preset-env"]
            }
          }
        },
        {
          test: /\.(scss|css)$/,
          use: [
            isProduction ? MiniCssExtractPlugin.loader : "style-loader",
            "css-loader",
            {
              loader: "postcss-loader",
              options: {
                postcssOptions: {
                  plugins: [
                    require("autoprefixer")
                  ]
                }
              }
            },
            "sass-loader"
          ]
        },
        {
          test: /\.(png|jpe?g|gif|svg|eot|ttf|woff|woff2)$/,
          type: "asset/resource",
          generator: {
            filename: "images/[hash][ext][query]"
          }
        }
      ]
    },
    plugins: [
      new CleanWebpackPlugin(), // Cleans output directory on each build
      new MiniCssExtractPlugin({
        filename: "[name].css"
      }),
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery",
        Popper: ["popper.js", "default"]
      })
    ],
    devServer: {
      hot: true,
      contentBase: path.resolve(__dirname, "public/packs"),
      publicPath: "/packs/",
      port: 3035,
      headers: {
        "Access-Control-Allow-Origin": "*"
      }
    },
    devtool: isProduction ? "source-map" : "eval-source-map"
  };
};
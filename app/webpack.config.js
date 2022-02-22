const path = require("path");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  mode: 'development',
  entry: "./src/index.js",
  output: {
    filename: "index.js",
    path: path.resolve(__dirname,"dist"),
   
  },

  plugins: [
    new CopyWebpackPlugin([{ from: "./src/index.html", to: "index.html" }]),
   new CopyWebpackPlugin([{ from:"./src/index1.html",to:"index1.html"
   }]),
   new CopyWebpackPlugin([{
     from:"./src/BLC.jpg",to:"BLC.jpg"
   }]),
   new CopyWebpackPlugin([{ from: "./src/kkr.css", to: "kkr.css" }]),
   new CopyWebpackPlugin([{ from: "./src/kkr1.css", to: "kkr1.css" }]),
   new CopyWebpackPlugin([{ from: "./src/index2.html", to: "index2.html" }]),
   new CopyWebpackPlugin([{ from: "./src/index3.html", to: "index3.html" }]),
   new CopyWebpackPlugin([{ from: "./src/kha.css", to: "kha.css" }]),
   new CopyWebpackPlugin([{ from: "./src/index4.html", to: "index4.html" }]),
   new CopyWebpackPlugin([{ from: "./src/index5.html", to: "index5.html" }]),
   new CopyWebpackPlugin([{ from: "./src/index6.html", to: "index6.html" }]),
   new CopyWebpackPlugin([{ from: "./src/kha1.css", to: "kha1.css" }]),
   new CopyWebpackPlugin([{ from: "./src/kha2.css", to: "kha2.css" }]),
   new CopyWebpackPlugin([{ from: "./src/kha3.css", to: "kha3.css" }]),
  ],
  devServer: { 

    contentBase: path.join(__dirname,"dist"), compress: true
 },
               
};

import "script!jquery"
import "script!foundation-sites"
import App from "app";
import React from "react";
import ReactDOM from "react-dom";
import HelloWorld from "./hello_world";

console.log("Hello world!", App);

ReactDOM.render(<HelloWorld/>, document.getElementById("hello_world"));

$(document).foundation()

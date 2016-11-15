import "script!jquery";
import "jquery-ujs";
import "script!foundation-sites";
import App from "app";
import React from "react";
import ReactDOM from "react-dom";
import HelloWorld from "./hello_world";

console.log("Hello world!", App);

if(document.getElementById("hello_world")) {
  ReactDOM.render(<HelloWorld/>, document.getElementById("hello_world"));
}

$(document).foundation()

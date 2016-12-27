import "script!jquery";
import "jquery-ujs";
import "script!foundation-sites";
import Initializer from "./initializer";
import "./initializers/all";

$(function() {
  $(document).foundation();
  Initializer.initialize();
});

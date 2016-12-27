import React from "react";
import ReactDOM from "react-dom";
import PostBox from "components/posts/box";

class PostView {
  constructor(el) {
    let $el = $(el);
    let props = { canManage: $el.data("manage").toString() };
    ReactDOM.render(React.createElement(PostBox, props), el);
  }
}

App.initializer.addComponent(PostView, { name: "post-box" });

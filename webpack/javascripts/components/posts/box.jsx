import React from "react";
import PostStore from "stores/post_store";
import connectToStores from "alt-utils/lib/connectToStores";
import Header from "./header";
import Details from "./details";

@connectToStores
class PostBox extends React.Component {
  static getStores() {
    return [PostStore];
  }

  static getPropsFromStores() {
    return PostStore.getState();
  }

  render() {
    return (
      <div className="post-box">
        <Header post={this.props.post}/>
        <Details can{...this.props}/>
      </div>
    )
  }
}

export default PostBox;

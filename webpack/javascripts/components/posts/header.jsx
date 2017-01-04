import React from "react";

class PostHeader extends React.Component {
  render() {
    return (
      <div className="callout large primary">
        <div className="row column text-center">
          <h1>{this.props.post.title}</h1>
          <h4 className="subheader">
            <p>Posted by: {this.props.post.author.full_name}</p>
            <p>Current rating: {this.props.post.rating}</p>
          </h4>
        </div>
      </div>
    )
  }
}

export default PostHeader;

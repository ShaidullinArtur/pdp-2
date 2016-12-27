import React from "react";
import CommentsBox from "./comments/box";

class PostDetails extends React.Component {
  render() {
    return (
      <div className="row medium-8 large-7 columns">
        <div className="post-details column">{this.props.post.text}</div>
        {this._actions()}
        <CommentsBox postId={this.props.post.id} canManage={this.props.canManage}/>
      </div>
    )
  }

  _actions() {
    if (this.props.canManage != "true") { return null; }
    return (
      <div className="medium-offset-8 medium-4 columns">
        <div className="button-group">
          <a href={`/posts/${this.props.post.id}/edit`} className="small button">Edit</a>
          <a
            href={`/posts/${this.props.post.id}`}
            data-method="delete"
            data-confirm="Are you sure?"
            className="small alert button">
            Destroy
          </a>
        </div>
      </div>
    )
  }
}

export default PostDetails;

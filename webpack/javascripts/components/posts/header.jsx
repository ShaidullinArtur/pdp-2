import React from "react";
import StarsRatingBox from "./stars/box";
import PostsActions from "actions/posts_actions";

class PostHeader extends React.Component {
  changeRating(value) {
    PostsActions.updateRating(this.props.post.id, value);
  }

  render() {
    return (
      <div className="callout large primary">
        <div className="row column text-center">
          <h1>{this.props.post.title}</h1>
          <h4 className="subheader">
            <p>Posted by: {this.props.post.author.full_name}</p>
            <p>Current rating: {this.props.post.rating}</p>
            {this._stars()}
          </h4>
        </div>
      </div>
    )
  }

  _stars() {
    if (App.currentUserData == null || this.props.post.author.id == App.currentUserData.id) { return; }
    return <StarsRatingBox onChange={this.changeRating.bind(this)} value={this.props.post.user_rating}/>;
  }
}

export default PostHeader;

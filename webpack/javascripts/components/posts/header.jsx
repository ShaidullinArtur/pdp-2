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
          <h1 className="text-wraped">{this.props.post.title}</h1>
          <h4 className="subheader">
            <p>Posted by: {this.props.post.author.full_name}</p>
            {this._currentRating()}
            <div className="clearfix"/>
            {this._stars()}
          </h4>
        </div>
      </div>
    )
  }

  _currentRating() {
    if (this.props.post.rating == 0) { return; }
    return (
      <div className="post-current-rating">
        <span>Current rating:</span>
        <StarsRatingBox editable={false} value={this.props.post.rating}/>
      </div>
    );
  }

  _stars() {
    if (App.currentUserData == null || this.props.post.author.id == App.currentUserData.id) { return; }
    return (
      <div className="post-user-rating">
        <span>Your rating:</span>
        <StarsRatingBox onChange={this.changeRating.bind(this)} value={this.props.post.user_rating}/>
      </div>
    );
  }
}

export default PostHeader;

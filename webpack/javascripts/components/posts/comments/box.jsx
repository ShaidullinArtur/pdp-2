import React from "react";
import connectToStores from "alt-utils/lib/connectToStores";
import CommentsStore from "stores/comments_store";
import CommentsActions from "actions/comments_actions";
import CommentForm from "./form";
import CommentsList from "./list";
import LoadMoreButton from "components/shared/load_more_button";

@connectToStores
class CommentsBox extends React.Component {
  static getStores() {
    return [CommentsStore];
  }

  static getPropsFromStores() {
    return CommentsStore.getState();
  }

  saveComment(commentText) {
    CommentsActions.save(this.props.postId, commentText);
  }

  updateComment(commentId, commentText) {
    CommentsActions.update(this.props.postId, commentId, commentText);
  }

  deleteComment(commentId) {
    CommentsActions.delete(this.props.postId, commentId);
  }

  loadComments() {
    CommentsActions.loadMore(this.props.postId, this.props.page + 1);
  }

  render() {
    return (
      <div className="post-comments-box columns">
        <h4 className="text-center">Comments</h4>
        <br/>
        {this._commentForm()}
        <CommentsList
          comments={this.props.comments}
          canManage={this.props.canManage}
          onUpdate={this.updateComment.bind(this)}
          onDelete={this.deleteComment.bind(this)} />
        <LoadMoreButton
          buttonText="Load more comments"
          lastPage={this.props.lastPage}
          loading={this.props.loading}
          onClick={this.loadComments.bind(this)} />
      </div>
    )
  }

  _commentForm() {
    if (App.currentUserData == null) { return; }
    return <CommentForm onSubmit={this.saveComment.bind(this)}/>;
  }
}

export default CommentsBox;

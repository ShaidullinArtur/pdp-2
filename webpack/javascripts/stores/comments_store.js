import CommentsActions from "actions/comments_actions";
import alt from "fluxer";
import qwest from "qwest";
import { findIndex } from "lodash";

class CommentsStore {
  constructor() {
    this.comments = App.commentsData;
    this.page = 1;
    this.lastPage = false;
    this.loading = false;

    this.bindListeners({
      append: CommentsActions.LOAD_MORE,
      add: CommentsActions.SAVE,
      update: CommentsActions.UPDATE,
      delete: CommentsActions.DELETE,
      startLoading: CommentsActions.START_LOADING
    });
  }

  append(comments) {
    this.loading = false;
    this.page += 1;
    this.lastPage = comments.length == 0;
    this.comments = this.comments.concat(comments);
  }

  add(comment) {
    this.comments.unshift(comment);
  }

  update(comment) {
    const commentIndex = findIndex(this.comments, (item) => item.id == comment.id);
    this.comments[commentIndex] = comment;
  }

  delete(commentId) {
    this.comments = this.comments.filter((comment) => comment.id !== commentId)
  }

  startLoading() {
    this.loading = true;
  }
}

export default alt.createStore(CommentsStore, "CommentsStore");

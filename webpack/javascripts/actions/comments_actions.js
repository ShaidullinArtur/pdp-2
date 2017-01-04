import alt from "fluxer";
import qwest from "qwest";
import authenticityToken from "utils/authenticityToken";

class CommentsActions {
  startLoading() {
    return true;
  }

  loadMore(postId, page) {
    this.startLoading();
    return (dispatch) => {
      qwest.get(`/posts/${postId}/comments.json`, { page: page })
       .then((xhr, response) => {
          dispatch(response);
       });
    };
  }

  save(postId, text) {
    return (dispatch) => {
      qwest.post(`/posts/${postId}/comments.json`, { comment: { text: text }, authenticity_token: authenticityToken })
       .then((xhr, response) => {
          dispatch(response);
       });
    };
  }

  update(postId, commentId, text) {
    return (dispatch) => {
      const data = { comment: { text: text }, authenticity_token: authenticityToken };
      qwest.put(`/posts/${postId}/comments/${commentId}.json`, data)
       .then((xhr, response) => {
          dispatch(response);
       });
    };
  }

  delete(postId, commentId) {
    return (dispatch) => {
      qwest.delete(`/posts/${postId}/comments/${commentId}.json`, { authenticity_token: authenticityToken })
       .then((xhr, response) => {
          dispatch(commentId);
       });
    };
  }
}

export default alt.createActions(CommentsActions);

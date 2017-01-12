import alt from "fluxer";
import qwest from "qwest";
import authenticityToken from "utils/authenticity_token";

class PostsActions {
  updateRating(postId, value) {
    return (dispatch) => {
      const data = { rating: { value: value }, authenticity_token: authenticityToken };
      qwest.put(`/posts/${postId}/rating.json`, data)
       .then((xhr, response) => {
          dispatch(response);
       });
    };
  }
}

export default alt.createActions(PostsActions);

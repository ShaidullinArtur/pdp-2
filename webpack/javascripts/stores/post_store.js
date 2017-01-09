import alt from "fluxer";
import PostsActions from "actions/posts_actions";

class PostStore {
  constructor() {
    this.post = App.postData;

    this.bindListeners({
      updateRating: PostsActions.UPDATE_RATING
    });
  }

  updateRating(post) {
    this.post = post;
  }
}

export default alt.createStore(PostStore, "PostStore");

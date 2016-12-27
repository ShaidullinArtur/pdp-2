import alt from "fluxer";

class PostStore {
  constructor() {
    this.post = App.postData;
  }
}

export default alt.createStore(PostStore, "PostStore");

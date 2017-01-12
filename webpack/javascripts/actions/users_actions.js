import alt from "fluxer";
import qwest from "qwest";
import { merge } from "lodash";
import { fetchUsers } from "sources/UserSource";

class UsersActions {
  startLoading() {
    return true;
  }

  filterUsers(params) {
    console.log(params);
    this.startLoading();
    return fetchUsers(merge({}, params, { page: 1 }));
  }

  loadMore(params, page) {
    this.startLoading();
    return fetchUsers(merge({}, params, { page: page }))
  }
}

export default alt.createActions(UsersActions);

import alt from "fluxer";
import qwest from "qwest";

import UsersActions from "actions/users_actions";

class UsersStore {
  constructor() {
    this.users = App.usersData || [];
    this.lastPage = this.users.length == 0;
    this.loading = false;
    this.params = { page: 1, search: "", sort: "" };

    this.bindListeners({
      append: UsersActions.LOAD_MORE,
      replaceUsers: UsersActions.FILTER_USERS,
      startLoading: UsersActions.START_LOADING
    });
  }

  append(data) {
    this.params = data.params;
    this.loading = false;
    this.lastPage = data.users.length == 0;
    this.users = this.users.concat(data.users);
  }

  replaceUsers(data) {
    this.params = data.params;
    this.loading = false;
    this.lastPage = false;
    this.users = data.users;
  }

  startLoading() {
    this.loading = true;
  }
}

export default alt.createStore(UsersStore, "UsersStore");

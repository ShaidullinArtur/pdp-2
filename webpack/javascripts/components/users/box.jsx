import React from "react";
import UsersStore from "stores/users_store";
import connectToStores from "alt-utils/lib/connectToStores";
import UsersActions from "actions/users_actions";
import Filters from "./filters";
import List from "./list";
import LoadMoreButton from "components/shared/load_more_button";

@connectToStores
class CompanyUsersBox extends React.Component {
  static getStores() {
    return [UsersStore];
  }

  static getPropsFromStores() {
    return UsersStore.getState();
  }

  onFiltersChanged(params) {
    UsersActions.filterUsers(params);
  }

  loadUsers() {
    UsersActions.loadMore(this.props.params, this.props.params.page + 1);
  }

  render() {
    return (
      <div className="row">
        <Filters params={this.props.params} onFiltersChange={this.onFiltersChanged}/>
        <hr/>
        <List collection={this.props.users}/>
        <br/>
        <LoadMoreButton
          lastPage={this.props.lastPage}
          loading={this.props.loading}
          onClick={this.loadUsers.bind(this)} />
      </div>
    )
  }
}

export default CompanyUsersBox;

import React from "react";
import ReactDOM from "react-dom";
import UsersBox from "components/users/box";

class CompanyUsersView {
  constructor(el) {
    ReactDOM.render(React.createElement(UsersBox), el);
  }
}

App.initializer.addComponent(CompanyUsersView, { name: "company-users-box" });

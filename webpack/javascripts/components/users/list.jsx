import React from "react";
import Item from "./item";

class CompanyUsersList extends React.Component {
  _items() {
    const items = this.props.collection.map((item) => { return <Item key={item.id} {...item}/>; })
    return (
      <table className="row column company-users-list">
        <thead>
          <tr>
            <th>Full Name</th>
            <th className="text-center">Posts Count</th>
            <th className="text-center">Average Rating</th>
          </tr>
        </thead>
        <tbody>{items}</tbody>
      </table>
    );
  }

  _empty() {
    return (
      <div className="row column company-users-list">
        Empty users list
      </div>
    );
  }

  render() {
    return this.props.collection.length > 0 ? this._items() : this._empty();
  }
}

export default CompanyUsersList;

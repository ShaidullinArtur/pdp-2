import React from "react";

class CompanyUserItem extends React.Component {

  render() {
    return (
      <tr className="company-users-item" data-id={this.props.id}>
        <td>
          {this.props.full_name}
        </td>
        <td className="text-center">
          {this.props.posts_count}
        </td>
        <td className="text-center">
          {this.props.average_rating}
        </td>
      </tr>
    );
  }
}

export default CompanyUserItem;

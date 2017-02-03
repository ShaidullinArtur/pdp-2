import React from "react";
import CommentItem from "./item";
import { map } from "lodash";

class CommentsList extends React.Component {

  render() {
    return <div className="post-comments-list row">{this.items()}</div>
  }

  items() {
    return map(this.props.comments, (item) => {
      return <CommentItem
        key={item.id}
        {...item}
        canManage={this.props.canManage}
        onUpdate={this.props.onUpdate}
        onDelete={this.props.onDelete} />
    })
  }
}

export default CommentsList;

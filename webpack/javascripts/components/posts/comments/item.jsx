import React from "react";
import CommentForm from "./form";
import moment from "moment";

class CommentItem extends React.Component {
  constructor() {
    super();

    this.state = {
      editable: false
    };
  }

  handleEdit(e) {
    e.preventDefault();
    this.setState({ editable: true })
  }

  handleCancel() {
    this.setState({ editable: false })
  }

  handleDestroy(e) {
    e.preventDefault();
    if (confirm("Are you sure?")) {
      this.props.onDelete(this.props.id);
    }
  }

  handleUpdate(text) {
    this.setState({ editable: false })
    this.props.onUpdate(this.props.id, text)
  }

  render() {
    return (
      <div className="medium-12 columns post-comments-item">
        <div className="medium-2 columns">
          <p>{this.props.author.full_name}</p>
        </div>
        {this._editableView()}
        {this._showView()}
        {this._actions()}
      </div>
    )
  }

  _editableView() {
    if (!this.state.editable) { return; }
    return (
      <div className="medium-10 columns">
        <CommentForm
          text={this.props.text}
          onSubmit={this.handleUpdate.bind(this)}
          onCancel={this.handleCancel.bind(this)}
        />
      </div>
    )
  }

  _showView() {
    if (this.state.editable) { return; }
    return (
      <div className="medium-8 columns">
        <p>{this.props.text}</p>
        <p>{moment(this.props.created_at).format("MM-DD-YYYY HH:mm:ss")}</p>
      </div>
    )
  }

  _actions() {
    if (this.state.editable) { return; }
    if (this._canManage()) {
      return (
        <div className="medium-2 columns">
          <div className="button-group">
            <a href="#" className="small button" onClick={this.handleEdit.bind(this)}>Edit</a>
            <a href="#" className="small alert button" onClick={this.handleDestroy.bind(this)}>Destroy</a>
          </div>
        </div>
      )
    }
  }

  _canManage() {
    return App.currentUserData != null &&
          (this.props.canManage == "true" || this.props.author.id == App.currentUserData.id);
  }
}

export default CommentItem;

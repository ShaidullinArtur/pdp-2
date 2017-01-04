import React from "react";
import classnames from "classnames";

class CommentForm extends React.Component {
  constructor(props) {
    super();

    this.state = {
      text: props.text || ""
    };
  }

  onChange(event) {
    this.setState({ text: event.target.value });
  }

  onSubmit(event) {
    event.preventDefault();
    if (this.state.text.length == 0) { return; }
    this.props.onSubmit(this.state.text);
    this.setState({ text: "" });
  }

  onCancel(event) {
    event.preventDefault();
    this.setState({ text: "" });
    if (this.props.onCancel != undefined) { this.props.onCancel(); }
  }

  render() {
    return (
      <form className="comments-form" onSubmit={this.onSubmit.bind(this)}>
        <label className="form-group">
          <textarea
            id="comment_text"
            className="comments-text"
            placeholder="Comment Text"
            onChange={this.onChange.bind(this)}
            value={this.state.text} />
        </label>
        <div className="button-group">
          <a href="#" className="button" onClick={this.onCancel.bind(this)}>
            Cancel
          </a>
          {this._submitButton()}
        </div>
      </form>
    );
  }

  _submitButton() {
    const classes = classnames("comments-button button radius", { disabled: this.state.text.length == 0 });
    return <button className={classes} type="submit">Save</button>
  }
}

export default CommentForm;

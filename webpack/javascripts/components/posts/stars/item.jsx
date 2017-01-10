import React from "react";
import classnames from "classnames";

class StarsRatingItem extends React.Component {
  static defaultProps = {
    active: false,
    editable: false
  };

  handleClick(e) {
    e.preventDefault();
    this.props.onClick(this.props.index);
  }

  handleMouseOver() {
    this.props.onMouseOver(this.props.index);
  }

  handleMouseOut() {
    this.props.onMouseOut();
  }

  classes() {
    return classnames({
      "fa fa-lg": true,
      "fa-star": this.props.active,
      "fa-star-o": !this.props.active
    });
  }

  _editableItem() {
    return (
      <a href="#"
         onClick={this.handleClick.bind(this)}
         onMouseOver={this.handleMouseOver.bind(this)}
         onMouseOut={this.handleMouseOut.bind(this)}>
        <i className={this.classes()}/>
      </a>
    );
  }

  _readOnlyItem() {
    return <i className={this.classes()}/>;
  }

  render() {
    return this.props.editable ? this._editableItem() : this._readOnlyItem();
  }
}

export default StarsRatingItem;

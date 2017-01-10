import React from "react";
import StarItem from "./item";
import { times } from "lodash";

class StarsRatingBox extends React.Component {
  static defaultProps = {
    count: 5,
    value: null,
    editable: true,
  };

  state = {
    value: this.props.value,
    hoveredItemIndex: null
  };

  setValue(index) {
    this.setState({ value: index });
    this.props.onChange(index);
  }

  setHoveredItem(index) {
    this.setState({ hoveredItemIndex: index });
  }

  clearHoveredItem() {
    this.setState({ hoveredItemIndex: null });
  }

  render() {
    return (
      <div className="star-rating">
        {this._stars()}
      </div>
    )
  }

  _stars() {
    return (
      times(this.props.count, (i) => {
        const index = i + 1;
        const props = {
          key: index,
          index: index,
          active: this.state.value >= index || index <= this.state.hoveredItemIndex,
          editable: this.props.editable,
          onClick: this.setValue.bind(this),
          onMouseOver: this.setHoveredItem.bind(this),
          onMouseOut: this.clearHoveredItem.bind(this)
        };
        return <StarItem {...props}/>;
      })
    );
  }
}

export default StarsRatingBox;

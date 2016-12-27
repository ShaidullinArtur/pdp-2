import React from "react";

class LoadMore extends React.Component {
  render() {
    if (this.props.lastPage) { return <div/>; };
    if (this.props.loading) {
      return <button className="medium-12 button disabled">Loading...</button>
    } else {
      return <button className="medium-12 button" onClick={this.props.onClick}>Load More</button>
    }
  }
}

export default LoadMore;

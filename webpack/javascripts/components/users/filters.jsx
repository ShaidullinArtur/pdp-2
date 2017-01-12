import React from "react";
import { debounce } from "lodash";

class CompanyUsersFilters extends React.Component {
  state = {
    sort: this.props.params.sort || "",
    search: this.props.params.search || "",
    min_rating: this.props.params.min_rating || "",
  };

  componentDidMount() {
    this.debounceTriggerFiltersChanged = debounce(this.triggerFiltersChanged, 500)
  }

  handleSelectChange(key, e) {
    this.setState({ sort: e.target.value });
    this.triggerFiltersChanged(key, e.target.value);
  }

  handleInputChange(e) {
    this.setState({ search: e.target.value });
    this.debounceTriggerFiltersChanged("search", e.target.value);
  }

  triggerFiltersChanged(name, value) {
    const params = this.state;
    params[name] = value;
    this.props.onFiltersChange(params);
  }

  render() {
    return (
      <div className="row company-users-filters">
        <div className="medium-3 columns">
          <select
            id="min_rating"
            value={this.state.min_rating}
            onChange={this.handleSelectChange.bind(this, "min_rating")} >
            <option value="">Min Rating</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
          </select>
        </div>
        <div className="medium-3 columns">
          <select
            id="sort"
            value={this.state.sort}
            onChange={this.handleSelectChange.bind(this, "sort")} >
            <option value="">Sorting</option>
            <option value="-average_rating,-posts_count">Average Rating</option>
            <option value="-posts_count,-average_rating">Posts Count</option>
          </select>
        </div>
        <div className="medium-6 columns">
          <input
            id="search"
            type="text"
            value={this.state.search}
            onChange={this.handleInputChange.bind(this)}
            placeholder="Search by name or email"/>
        </div>
      </div>
    );
  }
}

export default CompanyUsersFilters;

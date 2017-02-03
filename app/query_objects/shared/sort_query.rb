module Shared
  class SortQuery < BaseQuery
    def all
      relation.order(order)
    end

    private

    # sort_param = { sort: "name" }        # => "name asc"
    # sort_param = { sort: "id,-name" }    # => "id asc, name desc"
    # sort_param = {}                      # => ""
    def order
      ordering_values.join(", ")
    end

    def ordering_values
      sort_param.split(",").map do |param|
        param[0] == "-" ? "#{param[1..-1]} desc" : "#{param} asc"
      end
    end

    def sort_param
      params[:sort].to_s
    end
  end
end

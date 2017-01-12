class FilteredUsersQuery < BaseQuery
  PER_PAGE = 10
  ALLOWED_PARAMS = %i(min_rating sort search page).freeze

  def all
    params.slice(*ALLOWED_PARAMS).reduce(relation) do |users, (key, value)|
      send("by_#{key}", users, value)
    end
  end

  private

  def by_min_rating(users, rating)
    users.where("users.average_rating >= ?", rating)
  end

  def by_sort(users, query)
    Shared::SortQuery.new(users, sort: query).all
  end

  def by_search(users, query)
    users.search(query).with_pg_search_rank
  end

  def by_page(users, page)
    users.page(page).per(PER_PAGE)
  end
end

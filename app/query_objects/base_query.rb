class BaseQuery
  attr_reader :relation, :params

  def initialize(relation, params = {})
    @relation = relation
    @params = params.symbolize_keys
  end

  def all
    # template method
  end
end

class PostPolicy < ApplicationPolicy
  def create?
    record.company == user.company
  end

  def manage?
    record.author == user || record.company.owner == user
  end
end

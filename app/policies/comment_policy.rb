class CommentPolicy < ApplicationPolicy
  def create?
    record.post.company.users.include?(user)
  end

  def manage?
    record.author == user || record.post.company.owner == user
  end
end

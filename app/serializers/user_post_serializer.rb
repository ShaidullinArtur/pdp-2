class UserPostSerializer < ApplicationSerializer
  attributes :id, :created_at, :title, :text, :rating, :user_rating

  belongs_to :author

  def user_rating
    object.ratings.find_by(user: current_user).try(:value)
  end
end

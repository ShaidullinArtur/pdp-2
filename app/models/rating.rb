class Rating < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :user, :post, presence: true
  validates :user, uniqueness: { scope: :post_id }
end

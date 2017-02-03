class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: User, foreign_key: :user_id

  validates :author, :post, :text, presence: true
end

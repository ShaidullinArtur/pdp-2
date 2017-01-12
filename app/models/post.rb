class Post < ActiveRecord::Base
  belongs_to :company
  belongs_to :author, class_name: User, foreign_key: :user_id, counter_cache: true

  has_many :ratings
  has_many :comments

  validates :title, :author, :company, :text, presence: true
  validates :title, uniqueness: { scope: :company_id }
end

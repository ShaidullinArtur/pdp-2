class Company < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  belongs_to :owner, class_name: User, foreign_key: :user_id

  validates :subdomain, uniqueness: true
  validates :title, :owner, :subdomain, presence: true
  validates :title, uniqueness: { scope: :user_id }

  accepts_nested_attributes_for :owner
end

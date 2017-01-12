class User < ActiveRecord::Base
  include PgSearch

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, request_keys: { subdomain: false }

  validates :full_name, :email, presence: true
  validates :email, uniqueness: { scope: :subdomain }, allow_blank: true, if: :email_changed?
  validates :email, format: Devise.email_regexp, allow_blank: true, if: :email_changed?
  validates :password, presence: true, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password, length: Devise.password_length, allow_blank: true

  has_one :my_company, class_name: Company, dependent: :destroy
  has_one :company, foreign_key: :subdomain, primary_key: :subdomain

  has_many :posts

  pg_search_scope :search,
    against: [
      [:full_name, "A"],
      [:email, "A"]
    ],
    using: { tsearch: { prefix: true } }

  def self.find_for_authentication(warden_conditions)
    find_by(email: warden_conditions[:email], subdomain: warden_conditions[:subdomain])
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end

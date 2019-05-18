class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  enum role: {active: 0, admin: 1}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length:
    {maximum: Settings.name_length_max}
  validates :email, presence: true, length:
    {maximum: Settings.email_length_max},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length:
    {minimum: Settings.password_length_min}, allow_nil: true
  before_save :downcase_email
  has_many :suggestions
  has_many :orders
  has_many :rates
  scope :sort_by_created_at, ->{order created_at: :asc}

  private

  def downcase_email
    self.email = email.downcase
  end
end

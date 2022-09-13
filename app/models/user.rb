class User < ApplicationRecord
  before_save { self.username = username.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  has_many :folders, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :repos, dependent: :destroy
  has_one_attached :avatar

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :username, presence: true, 
              uniqueness: { case_sensitive: false }, 
              length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
              uniqueness: { case_sensitive: false }, 
              length: { maximum: 105 },
              format: { with: VALID_EMAIL_REGEX }

  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

  attr_writer :login
  validate :validate_username

  def login
    @login || username || email
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value",
      { value: login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  extend FriendlyId 
  friendly_id :username, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    username_changed? || new_record? || slug.nil? || slug.blank?
  end

  def timeout_in
    # return 1.year if admin?
    # 5.seconds
    1.days
  end
end

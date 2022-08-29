class Item < ApplicationRecord
  belongs_to :repo
  belongs_to :folder, optional: true
  validates :posts, presence: true
  has_many_attached :posts
  belongs_to :user
end

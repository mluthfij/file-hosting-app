class Item < ApplicationRecord
  belongs_to :repo
  belongs_to :folder, optional: true
  validates :posts, presence: true
  has_many_attached :posts
  belongs_to :user
  
  extend FriendlyId 
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def rand_s
    string_length = 11
    rand(36**string_length).to_s(36)
  end
    
  def slug_candidates
    [
      :rand_s
    ]
  end
end

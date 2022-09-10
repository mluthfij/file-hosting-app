class Folder < ApplicationRecord
  belongs_to :repo
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :folders, foreign_key: 'parent_id', dependent: :destroy
  has_many :items, foreign_key: 'folder_id', dependent: :destroy
  validates :name, presence: true
  belongs_to :user

  
  extend FriendlyId 
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def rand_s
    string_length = 5
    rand(36**string_length).to_s(36)
  end
    
  def slug_candidates
    [
      [:name, :rand_s]
    ]
  end
end

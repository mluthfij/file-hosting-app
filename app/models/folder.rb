class Folder < ApplicationRecord
  belongs_to :repo
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :folders, foreign_key: 'parent_id', dependent: :destroy
  has_many :items, foreign_key: 'folder_id', dependent: :destroy
  validates :name, presence: true
  belongs_to :user
end

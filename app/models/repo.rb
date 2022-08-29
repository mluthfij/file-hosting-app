class Repo < ApplicationRecord
    paginates_per 6
    has_many :folders, dependent: :destroy
    has_many :items, dependent: :destroy
    validates :name, presence: true
    belongs_to :user
end

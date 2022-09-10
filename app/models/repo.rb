class Repo < ApplicationRecord
    paginates_per 6
    has_many :folders, dependent: :destroy
    has_many :items, dependent: :destroy
    validates :name, presence: true, uniqueness: true
    belongs_to :user

    extend FriendlyId 
    friendly_id :slug_candidates, use: [:slugged, :finders]

    def should_generate_new_friendly_id?
        name_changed?
    end

    def rand_s
        string_length = 11
        rand(36**string_length).to_s(36)
    end
    
    def slug_candidates
        [
            # :name,
            [:name, :rand_s]
        ]
    end
end

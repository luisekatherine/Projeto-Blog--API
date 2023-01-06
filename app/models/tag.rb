class Tag < ApplicationRecord
    has_and_belongs_to_many :posts

    validates :name, presence: true, length: { within: 3..20 }, uniqueness: true

    default_scope { order(:name) } 
    #ou vai no controller, na index das tags e coloca @tags = Tag.all.order(:name)

    scope :starting_with, ->(word) { where("name LIKE ?", "#{word}%") }

end

class Like < ApplicationRecord
    belongs_to :likeable, :polymorphic => true
    belongs_to :user
    validates :user, uniqueness: { scope: :likeable }
end
class Tag < ApplicationRecord
    validates :name, presence: true, length: { within: 3..20 }, uniqueness: true
end

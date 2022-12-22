class Post < ApplicationRecord
    validates :title, length: {in: 10..255}, uniqueness: true
    #validates: :description, length: {minimum: 10}
    #validates: :title, presence: true
end

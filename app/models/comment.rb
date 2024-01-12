class Comment < ApplicationRecord
  belongs_to :film
  belongs_to :user
  validates :body, presence: true
end

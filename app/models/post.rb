class Post < ApplicationRecord
  validates :tweet, presence: true, length: { maximum: 50 }
  belongs_to :user
end

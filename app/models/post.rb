class Post < ApplicationRecord
  extend ActiveRecord::Enum
  enum time_slot: { morning: 0, afternoon: 1, evening: 2 }

  belongs_to :user
  validates :tweet, presence: true, length: { maximum: 50 }
  validates :time_slot, presence: true
end

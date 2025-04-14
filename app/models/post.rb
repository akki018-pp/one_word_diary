class Post < ApplicationRecord
  extend ActiveRecord::Enum
  enum time_slot: { morning: 0, afternoon: 1, evening: 2 }

  belongs_to :user
  validates :tweet, presence: true, length: { maximum: 50 }
  validates :time_slot, presence: true

  scope :created_between, ->(start_time, end_time) {
    where(created_at: start_time...end_time)
  }

  scope :for_today_slot, ->(slot) {
    base = Time.zone.now.beginning_of_day

    ranges = {
      morning:   (base + 6.hours)...(base + 12.hours),
      afternoon: (base + 12.hours)...(base + 18.hours),
      evening:   (base + 18.hours)..base.end_of_day
    }

    range = ranges[slot.to_sym]
    range ? created_between(range.begin, range.end) : none
  }
end

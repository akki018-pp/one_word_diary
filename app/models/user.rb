class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy

  def posts_by_time_slot_for_today
    Post.time_slots.keys.index_with do |slot|
      posts.where(time_slot: slot, created_at: Time.zone.today.all_day)
           .order(created_at: :desc)
    end
  end

  def posted_in?(slot)
    posts.exists?(time_slot: Post.time_slots[slot], created_at: Time.zone.today.all_day)
  end
end

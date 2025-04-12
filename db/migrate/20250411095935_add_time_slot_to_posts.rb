class AddTimeSlotToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :time_slot, :integer, using: 'time_slot::integer', default: 0, null: false
  end
end

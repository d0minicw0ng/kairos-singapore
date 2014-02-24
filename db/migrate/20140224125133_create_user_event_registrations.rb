class CreateUserEventRegistrations < ActiveRecord::Migration
  def change
    create_table :user_event_registrations do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.string :state, null: false, default: 'pending'

      t.timestamps
    end
  end
end

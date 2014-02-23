class CreateProjectEventRegistrations < ActiveRecord::Migration
  def change
    create_table :project_event_registrations do |t|
      t.integer :project_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end
  end
end

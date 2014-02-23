class AddStateToProjectEventRegistration < ActiveRecord::Migration
  def change
    add_column :project_event_registrations, :state, :string, default: 'pending', null: false
  end
end

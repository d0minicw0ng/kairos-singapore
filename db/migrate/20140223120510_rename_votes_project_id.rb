class RenameVotesProjectId < ActiveRecord::Migration
  def up
    rename_column :votes, :project_id, :project_event_registration_id
  end

  def down
    rename_column :votes, :project_event_registration_id, :project_id
  end
end

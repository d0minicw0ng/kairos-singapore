class AddProjectIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :project_id, :integer, null: false
  end
end

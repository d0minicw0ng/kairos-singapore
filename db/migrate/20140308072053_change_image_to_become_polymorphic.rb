class ChangeImageToBecomePolymorphic < ActiveRecord::Migration
  def change
    rename_column :images, :project_id, :imageable_id
    add_column :images, :imageable_type, :string
  end
end

class AddTagTypeToTags < ActiveRecord::Migration
  def up
    add_column :tags, :tag_type, :string
  end

  def down
    remove_column :tags, :tag_type
  end
end

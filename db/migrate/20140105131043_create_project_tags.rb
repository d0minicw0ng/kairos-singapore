class CreateProjectTags < ActiveRecord::Migration
  def change
    create_table :project_tags do |t|
      t.integer :project_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end

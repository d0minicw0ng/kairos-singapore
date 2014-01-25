class AddSlugToProject < ActiveRecord::Migration
  def change
    add_column :projects, :slug, :string, unique: true
    add_index :projects, :slug, unique: true
  end
end

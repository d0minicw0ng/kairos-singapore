class AddUsernameAndSlugToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, unique: true, null: false
    add_column :users, :slug, :string, unique: true
    add_index :users, :slug, unique: true
  end
end

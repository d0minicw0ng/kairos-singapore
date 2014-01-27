class RenameUserType < ActiveRecord::Migration
  def change
    rename_column :users, :type, :member_type
  end
end

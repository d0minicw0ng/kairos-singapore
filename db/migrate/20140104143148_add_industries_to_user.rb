class AddIndustriesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :industries, :integer, null: false, default: 0
  end
end

class RenameEventAddressAttrs < ActiveRecord::Migration
  def change
    rename_column :events, :address_line_one, :street_one
    rename_column :events, :address_line_two, :street_two
  end
end

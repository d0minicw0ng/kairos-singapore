class AddAddressToEvent < ActiveRecord::Migration
  def change
    # NOTE: Although we only have events in Singapore at the moment,
    # but I can foresee regional events happening in the future, so
    # I am going to add city, state, and country as fields as well
    add_column :events, :venue_name, :string
    add_column :events, :address_line_one, :string
    add_column :events, :address_line_two, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :country, :string
    add_column :events, :zip_code, :string
  end
end

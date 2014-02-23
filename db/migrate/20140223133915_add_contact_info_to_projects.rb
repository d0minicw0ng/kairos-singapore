class AddContactInfoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :contact_email, :string
    add_column :projects, :contact_number, :string
  end
end

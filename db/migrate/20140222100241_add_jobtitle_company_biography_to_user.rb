class AddJobtitleCompanyBiographyToUser < ActiveRecord::Migration
  def change
    add_column :users, :job_title, :string
    add_column :users, :company, :string
    add_column :users, :biography, :text
  end
end

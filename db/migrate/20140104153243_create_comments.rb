class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :user_id, null: false
    	t.string :content, null: false
    	t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

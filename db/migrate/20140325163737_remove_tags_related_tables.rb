class RemoveTagsRelatedTables < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :project_tags
    drop_table :article_tags
  end
end

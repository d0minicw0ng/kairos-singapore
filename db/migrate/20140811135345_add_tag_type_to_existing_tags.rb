class AddTagTypeToExistingTags < ActiveRecord::Migration
  def change
    ActsAsTaggableOn::Tag.all.each do |tag|
      tag.update_attributes tag_type: "industry"
    end
  end
end

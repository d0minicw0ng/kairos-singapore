class AddSkillTagsToTag < ActiveRecord::Migration
  def change
    [
      "Business Development",
      "Sales",
      "Investment/Fundraising",
      "Accounting",
      "Business Operations",
      "Marketing",
      "Web Development",
      "Mobile Development",
      "Design",
      "User Experience",
      "Machine Learning",
      "Biotechnology",
      "Nanotechnology",
      "Mechanical Engineering",
      "Chemical Engineering",
      "Medicine",
      "Hardware Engineering",
      "Foreign Languages"
    ].each do |tag_name|
      ActsAsTaggableOn::Tag.create name: tag_name, tag_type: "skill"
    end
  end
end

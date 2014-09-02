class AddInterviewBasedQuestionsToUser < ActiveRecord::Migration
  def up
    add_column :users, :age, :integer
    add_column :users, :involvement_in_asean, :text
    add_column :users, :problem_solving_skills, :text
    add_column :users, :contribution_to_society, :text
    add_column :users, :leadership_quality, :text
    add_column :users, :industry_expertise, :text
    add_column :users, :vision, :text
    add_column :users, :entrepreneurial, :text
  end

  def down
    remove_column :users, :age
    remove_column :users, :involvement_in_asean
    remove_column :users, :problem_solving_skills
    remove_column :users, :contribution_to_society
    remove_column :users, :leadership_quality
    remove_column :users, :industry_expertise
    remove_column :users, :vision
    remove_column :users, :entrepreneurial
  end
end

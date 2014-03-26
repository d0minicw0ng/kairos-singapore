class CreateTags < ActiveRecord::Migration
  def change
    [
      'Clean Tech',
      'Health Care',
      'Big Data',
      'Information Technology and Services',
      'Venture Capital and Private Equity',
      'Management Consulting',
      'Government Administration',
      'Biomedical Science',
      'Medical Devices',
      'Education',
      'Professional Training and Coaching',
      'Media Production',
      'Non Profit Organization',
      'Artificial Intelligence',
      'Logistics and Supply Chain'
    ].each do |tag_name|
      ActsAsTaggableOn::Tag.create(name: tag_name)
    end
  end
end

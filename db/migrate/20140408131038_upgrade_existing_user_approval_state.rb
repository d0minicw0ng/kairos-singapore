class UpgradeExistingUserApprovalState < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_attributes(approved: true)
    end
  end
end

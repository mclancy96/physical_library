class AssignAdmin < ActiveRecord::Migration[7.1]
  def change
    admin = Role.find_by(name: 'admin')
    lilli = Member.where('name like ?', '%lilli%').first
    mike = Member.where('name like ?', '%Mike%').first
    if lilli&.exists?
      lilli.update_attribute(:role, admin.id)
    end
    if mike&.exists?
      mike.update_attribute(:role, admin.id)
    end

  end
end

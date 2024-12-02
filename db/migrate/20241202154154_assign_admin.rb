class AssignAdmin < ActiveRecord::Migration[7.1]
  def change
    admin = Role.find_by(code: 'admin')
    lilli = Member.where('name like ?', '%lilli%').first
    mike = Member.where('name like ?', '%Mike%').first
    lilli&.update_attribute(:role, admin)
    mike&.update_attribute(:role, admin)
  end
end

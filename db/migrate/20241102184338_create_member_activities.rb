class CreateMemberActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :member_activities do |t|

      t.timestamps
    end
  end
end

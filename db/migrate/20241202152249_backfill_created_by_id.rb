class BackfillCreatedById < ActiveRecord::Migration[7.1]
  def change
    mike = Member.where('name like ?', '%Mike%').first
    return unless mike

    Book.all.each do |book|
      book.update_attribute(:created_by_id, mike.id)
    end
  end
end

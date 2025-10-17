class RemoveUserFromChecklistItems < ActiveRecord::Migration[7.1]
  def change
    remove_reference :checklist_items, :user, null: false, foreign_key: true
  end
end

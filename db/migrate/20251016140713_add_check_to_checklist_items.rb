class AddCheckToChecklistItems < ActiveRecord::Migration[7.1]
  def change
    add_column :checklist_items, :check, :boolean, default: false, null: false
  end
end

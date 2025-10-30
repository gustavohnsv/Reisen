class CreateChecklistParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :checklist_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :checklist, null: false, foreign_key: true
      t.string :role, null: false, default: 'collaborator'

      t.timestamps
    end
    add_index :checklist_participants, [:checklist_id, :user_id], unique: true, name: 'index_checklist_participants_on_checklist_and_user'
  end
end

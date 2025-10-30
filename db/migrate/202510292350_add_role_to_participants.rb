class AddRoleToParticipants < ActiveRecord::Migration[7.1]
  def change
    add_column :participants, :role, :string, null: false, default: 'collaborator'
  end
end

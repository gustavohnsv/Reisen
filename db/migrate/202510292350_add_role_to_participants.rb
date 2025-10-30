class AddRoleToParticipants < ActiveRecord::Migration[7.1]
  def change
    if ActiveRecord::Base.connection.data_source_exists?(:participants)
      unless column_exists?(:participants, :role)
        add_column :participants, :role, :string, null: false, default: 'collaborator'
      end
    else
      warn "Skipping AddRoleToParticipants because participants table does not exist"
    end
  end
end

class AddRoleToParticipantsSafe < ActiveRecord::Migration[7.1]
  def change
    # Safe migration: only add the column if the table exists and the column is missing.
    return unless ActiveRecord::Base.connection.data_source_exists?(:participants)

    unless column_exists?(:participants, :role)
      add_column :participants, :role, :string, null: false, default: 'collaborator'
    end
  end
end

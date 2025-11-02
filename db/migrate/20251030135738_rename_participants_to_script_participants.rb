class RenameParticipantsToScriptParticipants < ActiveRecord::Migration[7.1]
  # This migration is defensive: some environments (CI/test) may not have the
  # original `participants` table (for example if migrations were squashed or
  # applied in a different order). We only rename when the source table exists.
  def up
    if table_exists?(:participants)
      rename_table :participants, :script_participants
    else
      say "Skipping rename: table 'participants' does not exist"
    end
  end

  def down
    if table_exists?(:script_participants)
      rename_table :script_participants, :participants
    else
      say "Skipping rename down: table 'script_participants' does not exist"
    end
  end
end

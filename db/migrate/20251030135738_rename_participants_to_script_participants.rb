class RenameParticipantsToScriptParticipants < ActiveRecord::Migration[7.1]
  def change
    rename_table :participants, :script_participants
  end
end

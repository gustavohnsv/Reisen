class RenameScriptSpentsToScriptSpends < ActiveRecord::Migration[8.1]
    def up
      if table_exists?(:script_spents)
        rename_table :script_spents, :script_spends
      else
        say "Skipping rename: table 'participants' does not exist"
      end
    end

    def down
      if table_exists?(:script_spends)
        rename_table :script_spends, :participants
      else
        say "Skipping rename down: table 'script_participants' does not exist"
      end
    end
end

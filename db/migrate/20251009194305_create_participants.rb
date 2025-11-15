class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.integer :permission
      t.references :user, null: false, foreign_key: true
      t.references :script, null: false, foreign_key: true

      t.timestamps
    end
  end
end

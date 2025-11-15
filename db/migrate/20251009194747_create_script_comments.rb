class CreateScriptComments < ActiveRecord::Migration[7.1]
  def change
    create_table :script_comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :script, null: false, foreign_key: true

      t.timestamps
    end
  end
end

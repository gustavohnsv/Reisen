class CreateScriptItemPhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :script_item_photos do |t|
      t.references :script_item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.timestamps
    end
  end
end
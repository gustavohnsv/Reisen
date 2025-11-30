# db/migrate/20251130162623_create_script_item_photos.rb
class CreateScriptItemPhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :script_item_photos do |t|
      t.references :script_item, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.text :description
      
      t.timestamps
    end
  end
end
class CreateScriptItemPhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :script_item_photos do |t|
      t.timestamps
    end
  end
end

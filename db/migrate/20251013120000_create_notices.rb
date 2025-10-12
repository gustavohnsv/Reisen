class CreateNotices < ActiveRecord::Migration[7.1]
  def change
    create_table :notices do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :visible, null: false, default: false
      t.references :user, null: true, foreign_key: true
      t.timestamps
    end
  end
end

class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment
      t.string :title

      t.timestamps
    end

    add_index :reviews, [:reviewable_type, :reviewable_id, :user_id], 
              unique: true, 
              name: 'index_reviews_on_reviewable_and_user'
  end
end
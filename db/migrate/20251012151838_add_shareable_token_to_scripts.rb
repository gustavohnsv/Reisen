class AddShareableTokenToScripts < ActiveRecord::Migration[7.1]
  def change
    add_column :scripts, :shareable_token, :string
    add_index :scripts, :shareable_token, unique: true
  end
end

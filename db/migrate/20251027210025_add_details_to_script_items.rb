class AddDetailsToScriptItems < ActiveRecord::Migration[7.1]
  def change
    add_column :script_items, :description, :string
    add_column :script_items, :location, :string
    add_column :script_items, :date_time_start, :datetime
    add_column :script_items, :estimated_cost, :decimal, precision: 10, scale: 2
  end
end

class AddDetailsToScriptSpents < ActiveRecord::Migration[8.1]
  def change
    add_column :script_spents, :date, :date
    add_column :script_spents, :category, :integer, default: 1
    add_column :script_spents, :quantity, :integer, default: 1
  end
end

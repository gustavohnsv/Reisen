class AllowNullUserOnScriptItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :script_items, :user_id, true
  end
end

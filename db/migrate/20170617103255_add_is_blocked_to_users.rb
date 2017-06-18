class AddIsBlockedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_blocked, :boolean, null: false, default: false
  end
end

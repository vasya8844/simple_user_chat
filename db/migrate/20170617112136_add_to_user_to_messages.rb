class AddToUserToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :to_user_id, :integer, null: false
    add_column :messages, :is_read, :boolean, null: false, default: false
  end
end

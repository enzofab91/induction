class AddUnreadMessagesCount < ActiveRecord::Migration[6.1]
  def change
    change_table :conversations, bulk: true do |t|
      t.integer :first_user_unread_messages, default: 0
      t.integer :second_user_unread_messages, default: 0
    end
  end
end

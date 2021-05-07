class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :match, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end

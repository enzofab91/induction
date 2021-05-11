class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :body, null: false
      t.timestamps

      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end

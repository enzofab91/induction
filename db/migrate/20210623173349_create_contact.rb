class CreateContact < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :body, null: false
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end

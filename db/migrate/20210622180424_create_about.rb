class CreateAbout < ActiveRecord::Migration[6.1]
  def change
    create_table :abouts do |t|
      t.string :body, null: false

      t.timestamps null: false
    end
  end
end

class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references  :first_user, null: false
      t.references  :second_user, null: false
      t.references  :target, null: false

      t.timestamps null: false
    end
  end
end

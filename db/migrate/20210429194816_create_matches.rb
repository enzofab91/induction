class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references  :first_user, null: false, foreign_key: true
      t.references  :second_user, null: false, foreign_key: true
      t.references  :target, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end

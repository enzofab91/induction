class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string      :title,                    null: false
      t.float       :radius,                   null: false
      t.float       :latitude,                 null: false
      t.float       :longitude,                null: false
      t.timestamps                             null: false

      t.references  :user, foreing_key: true,  null: false
      t.references  :topic,                    null: false
    end
  end
end

class AddTargetCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column('users', 'targets_count', :integer, null: false, default: 0)
  end
end

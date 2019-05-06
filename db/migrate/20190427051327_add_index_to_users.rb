class AddIndexToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :remember_token
  end
end

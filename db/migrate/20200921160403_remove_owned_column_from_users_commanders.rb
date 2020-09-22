class RemoveOwnedColumnFromUsersCommanders < ActiveRecord::Migration[6.0]
  def change
    remove_column :users_commanders, :owned
  end
end

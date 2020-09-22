class CreateUsersCommanders < ActiveRecord::Migration[6.0]
  def change
    create_table :users_commanders do |t|
      t.references :user, foreign_key: true
      t.references :commander, foreign_key: true
      t.boolean :owned, default: false
      t.integer :skill1, default: 1
      t.integer :skill2, default: 1
      t.integer :skill3, default: 1
      t.integer :skill4, default: 1
      t.timestamps
    end
  end
end

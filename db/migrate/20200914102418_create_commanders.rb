class CreateCommanders < ActiveRecord::Migration[6.0]
  def change
    create_table :commanders do |t|
      t.string :name, null: false
      t.string :rarity, null: false
      t.timestamps
    end
  end
end

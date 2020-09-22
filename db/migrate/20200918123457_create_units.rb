class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.integer :main_commander_id, null: false
      t.integer :sub_commander_id
      t.timestamps
    end
  end
end

class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :title, null: false
      t.text :details
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

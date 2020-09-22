class AddUnitsToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :unit1_id, :integer
    add_column :teams, :unit2_id, :integer
    add_column :teams, :unit3_id, :integer
    add_column :teams, :unit4_id, :integer
    add_column :teams, :unit5_id, :integer
  end
end

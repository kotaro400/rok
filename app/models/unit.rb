class Unit < ApplicationRecord

  validate :forbid_same_id
  validates :main_commander_id, presence: true

  def self.create_units(team_params)
    unit_ids = []
    5.times.each do |n|
      main_sym = "unit#{n + 1}_main".to_sym
      sub_sym = "unit#{n + 1}_sub".to_sym
      if team_params[main_sym].present?
        @unit = Unit.find_by(main_commander_id: team_params[main_sym], sub_commander_id: team_params[sub_sym])
        unless @unit
          @unit = Unit.new(main_commander_id: team_params[main_sym], sub_commander_id: team_params[sub_sym])
          unless @unit.save
            return @unit
          end
        end
        unit_ids.push(@unit.id)
      end
    end
    unit_ids
  end

  def main_commander
    Commander.find_by(id: main_commander_id)
  end

  def sub_commander
    Commander.find_by(id: sub_commander_id)
  end

  private
  def forbid_same_id
    errors.add(:base, "主将と副将が同じです") if main_commander_id == sub_commander_id
  end
end

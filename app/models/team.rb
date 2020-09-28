class Team < ApplicationRecord
  include Hashid::Rails
  
  belongs_to :user

  validates :title, presence: true
  validates :title, length: {maximum: 30}
  validates :details, length: {maximum: 300}
  validate :forbid_same_commander

  def units
    [
      Unit.find_by(id: unit1_id),
      Unit.find_by(id: unit2_id),
      Unit.find_by(id: unit3_id),
      Unit.find_by(id: unit4_id),
      Unit.find_by(id: unit5_id)
    ].reject{|unit| unit.nil? }
  end

  def commanders
    units.map{|unit| unit.main_commander} + units.map{|unit| unit.sub_commander}
  end

  private
  def forbid_same_commander
    commander_ids = units.map{|unit| unit.main_commander_id } + units.map{|unit| unit.sub_commander_id }
    unless commander_ids.size == commander_ids.uniq.size
      errors.add(:base, "同じ指揮官が含まれています")
    end
  end
end

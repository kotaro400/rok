class Commander < ApplicationRecord
  has_many :users_commanders, dependent: :destroy

  scope :owned, -> (user_id) { includes(:users_commanders).where(users_commanders: {user_id: user_id}) }

  def self.sort_by_skill_level(user_id)
    Commander.owned(user_id).sort_by do |commander|
      commander.users_commanders.first.power
    end.reverse
  end

  def users_commander(user_id)
    users_commanders.find_by(user_id: user_id)
  end

  def max_sculpture_count
    case rarity
    when "レジェンド"
      700
    when "エピック"
      450
    end
  end

  def self.star_count(level, exp, rarity, type)
    star_exp = type == "average"? 160: 100
    case rarity
    when "legend"
      case level
      when 10
        (500 * (1 - exp / 100) / star_exp).ceil
      when 20
        (1000 * (1 - exp / 100) / star_exp).ceil
      when 30
        (6500 * (1 - exp / 100) / star_exp).ceil
      when 40
        (25000 * (1 - exp / 100) / star_exp).ceil
      when 50
        (65000 * (1 - exp / 100) / star_exp).ceil
      end
    when "epic"
      case level
      when 10
        (500 * (1 - exp / 100) / star_exp).ceil
      when 20
        (1000 * (1 - exp / 100) / star_exp).ceil
      when 30
        (6500 * (1 - exp / 100) / star_exp).ceil
      when 40
        (16000 * (1 - exp / 100) / star_exp).ceil
      when 50
        (47500 * (1 - exp / 100) / star_exp).ceil
      end
    end
  end
end

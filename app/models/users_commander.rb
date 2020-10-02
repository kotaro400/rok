class UsersCommander < ApplicationRecord
  belongs_to :user
  belongs_to :commander

  validates :skill1, inclusion: {in: [1, 2, 3, 4, 5]}
  validates :skill2, inclusion: {in: [1, 2, 3, 4, 5]}
  validates :skill3, inclusion: {in: [1, 2, 3, 4, 5]}
  validates :skill4, inclusion: {in: [1, 2, 3, 4, 5]}
  validates :commander_id, uniqueness: { scope: :user_id }

  def power
    rarity = commander.rarity == "レジェンド" ? 0.5: 0.4
    skill1 + skill2 + skill3 + skill4 + rarity
  end

  def sculpture_count
    legend_sculptures = [10, 10, 15, 15, 30, 30, 40, 40, 45, 45, 50, 50, 75, 75, 80, 80]
    epic_sculptures = [10, 10, 10, 20, 20, 20, 20, 30, 30, 30, 30, 40, 40, 40, 40, 50]
    skill_point = skill1 + skill2 + skill3 + skill4 - 4
    case commander.rarity
    when "レジェンド"
      legend_sculptures.slice(skill_point..15).sum
    when "エピック"
      epic_sculptures.slice(skill_point..15).sum
    end
  end

  def sculptures_for_5551
    sculpture_count - 310 > 0 ? sculpture_count - 310: 0
  end

  def sculptures_for_5511
    sculpture_count - 500 > 0 ? sculpture_count - 500: 0
  end

  def sculptures_for_5111
    sculpture_count - 640 > 0 ? sculpture_count - 640: 0
  end

  def update_users_commander(skill, type)
    val = type == "up" ? 1: - 1
    case type
    when "up", "down"
      case skill
      when "1"
        update(skill1: skill1 + val)
      when "2"
        update(skill2: skill2 + val)
      when "3"
        update(skill3: skill3 + val)
      when "4"
        update(skill4: skill4 + val)
      end
    when "full"
      res = update(
        skill1: 5,
        skill2: 5,
        skill3: 5,
        skill4: 5,
      )
    end
  end

end

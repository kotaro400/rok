class Commander < ApplicationRecord
  has_many :users_commanders, dependent: :destroy

  scope :owned, -> (user_id) { includes(:users_commanders).where(users_commanders: {user_id: user_id}) }

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
end

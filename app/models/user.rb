class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :users_commanders, dependent: :destroy
  has_many :teams, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: true }
  validates :name, presence: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["name = :value", { value: name }]).first
    else
      where(conditions).first
    end
  end

  def commanders_sorted_by_skill
    users_commanders.sort_by{|commander| commander.power }.reverse
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end  
end

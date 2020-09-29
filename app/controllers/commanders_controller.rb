class CommandersController < ApplicationController

  def index
    @owned_commanders = current_user.commanders_sorted_by_skill
    @not_owned_commanders = Commander.where.not(id: @owned_commanders.map{|commander| commander.commander_id})
  end

  def show
    @commander = Commander.find_by(name: params[:name])
    @users_commander = current_user.users_commanders.find_by(commander_id: @commander.id)
  end

  def search
    case params[:type]
    when "skill"
      @owned_commanders = current_user.commanders_sorted_by_skill
      @not_owned_commanders = Commander.where.not(id: @owned_commanders.map{|commander| commander.commander_id})
    when "not_owned"
      @owned_commanders = []
      owned_commander_ids = current_user.commanders_sorted_by_skill.map do |users_commander|
        users_commander.commander.id
      end
      @not_owned_commanders = Commander.where.not(id: owned_commander_ids)
    else
      @owned_commanders = current_user.commanders_sorted_by_skill.select do |users_commander|
        users_commander.commander.rarity == params[:type]
      end
      owned_commander_ids = current_user.commanders_sorted_by_skill.map do |users_commander|
        users_commander.commander.id
      end
      @not_owned_commanders = Commander.where.not(id: owned_commander_ids).select{|commander| commander.rarity == params[:type]}
    end
  end

end

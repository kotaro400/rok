class CommandersController < ApplicationController

  def index
    @owned_commanders = Commander.sort_by_skill_level(current_user.id)
    @not_owned_commanders = Commander.where.not(id: @owned_commanders.map{|commander| commander.id})
  end

  def show
    @commander = Commander.find(params[:id])
    @users_commander = current_user.users_commanders.find_by(commander_id: params[:id])
  end

  def search
    case params[:type]
    when "skill"
      @owned_commanders = Commander.sort_by_skill_level(current_user.id)
      @not_owned_commanders = Commander.where.not(id: @owned_commanders.map{|commander| commander.id})
    when "not_owned"
      @owned_commanders = []
      owned_commander_ids = Commander.sort_by_skill_level(current_user.id).map{|commander| commander.id}
      @not_owned_commanders = Commander.where.not(id: owned_commander_ids)
    else
      @owned_commanders = Commander.sort_by_skill_level(current_user.id).select{|commander| commander.rarity == params[:type]}
      owned_commander_ids = Commander.sort_by_skill_level(current_user.id).map{|commander| commander.id}
      @not_owned_commanders = Commander.where.not(id: owned_commander_ids).select{|commander| commander.rarity == params[:type]}
    end
  end

end

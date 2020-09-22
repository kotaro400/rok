class CommandersController < ApplicationController

  def index
    @owned_commanders = Commander.owned(current_user.id)
    @not_owned_commanders = Commander.where.not(id: @owned_commanders.map{|commander| commander.id})
  end

  def show
    @commander = Commander.find(params[:id])
    @users_commander = current_user.users_commanders.find_by(commander_id: params[:id])
  end

end

class UsersCommandersController < ApplicationController

  def create
    @users_commander = current_user.users_commanders.build(commander_id: params[:commander_id])
    @commander = Commander.find(params[:commander_id])
    @users_commander.save
  end

  def update
    @users_commander = UsersCommander.find(params[:id])
    @commander = @users_commander.commander
    if @users_commander.update_users_commander(params[:skill], params[:type])
      render "update"
    else
      render "error"
    end
  end

end

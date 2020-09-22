class TeamsController < ApplicationController

  def index
    @teams = current_user.teams
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
    @commanders = Commander.all
  end

  def create
    unit_ids = Unit.create_units(params[:team])
    unless unit_ids.instance_of?(Array)
      redirect_to new_team_path, alert: unit_ids.errors.full_messages.first
      return
    end
    @team = current_user.teams.build(
      title: params[:team][:title],
      details: params[:team][:details],
      unit1_id: unit_ids[0],
      unit2_id: unit_ids[1],
      unit3_id: unit_ids[2],
      unit4_id: unit_ids[3],
      unit5_id: unit_ids[4],
    )
    if @team.save
      redirect_to commanders_path, notice: "編成が作成されました"
    else
      @commanders = Commander.all
      render "new"
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_path, notice: "編成を削除しました"
  end

end

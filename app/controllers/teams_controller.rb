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
    @team = current_user.teams.build(team_params(unit_ids))
    if @team.save
      redirect_to teams_path, notice: "編成が作成されました"
    else
      @commanders = Commander.all
      render "new"
    end
  end

  def edit
    @team = Team.find(params[:id])
    @commanders = Commander.all
  end

  def update
    @team = Team.find(params[:id])
    unit_ids = Unit.create_units(params[:team])
    unless unit_ids.instance_of?(Array)
      redirect_to new_team_path, alert: unit_ids.errors.full_messages.first
      return
    end
    if @team.update(team_params(unit_ids))
      redirect_to team_path(@team), notice: "編成を保存しました"
    else
      @commanders = Commander.all
      render "edit"
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_path, notice: "編成を削除しました"
  end

  private
  def team_params(unit_ids)
    {
      title: params[:team][:title],
      details: params[:team][:details],
      unit1_id: unit_ids[0],
      unit2_id: unit_ids[1],
      unit3_id: unit_ids[2],
      unit4_id: unit_ids[3],
      unit5_id: unit_ids[4],
    }
  end

end

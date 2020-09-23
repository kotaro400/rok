class RankController < ApplicationController
  skip_before_action :authenticate_user!

  def form
  end

  def calc
    @average_star =  Commander.star_count(params[:level].to_i, params[:exp].to_f, params[:rarity], "average")
    @worst_star = Commander.star_count(params[:level].to_i, params[:exp].to_f, params[:rarity], "worst")
  end

end

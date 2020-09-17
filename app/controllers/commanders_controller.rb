class CommandersController < ApplicationController
  def index
    @commanders = Commander.all
  end
end

class BlocksController < ApplicationController
  def blocks_show
    @blocks = Block.all
  end

  def new
    @block = Block.new
    @step = Step.find(params[:step_id].to_i)
  end

  def create

  end
end
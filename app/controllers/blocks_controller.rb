class BlocksController < ApplicationController
  def blocks_show
    @blocks = Block.all
  end
end
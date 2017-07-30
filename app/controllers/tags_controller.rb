class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id])
    @instructions = @tag.instructions
  end
end

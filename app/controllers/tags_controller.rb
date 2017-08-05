class TagsController < ApplicationController
  def show
    authorize! :show, Tag

    @tag = Tag.find_by(name: params[:id])
    @instructions = @tag.instructions
  end
end

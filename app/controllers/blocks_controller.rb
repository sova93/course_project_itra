class BlocksController < ApplicationController

  def new
    authorize! :create, Block
    @block = Block.new
    @block.step = Step.find(params[:step_id].to_i)
  end

  def show
    @block = Block.find(params[:id])
    authorize! :show, @block
  end

  def edit
    @block = Block.find(params[:id])
    authorize! :update, @block
  end

  def update
    @block = Block.find(params[:id])
    authorize! :update, @block
    block = block_params
    @block.block_type=block[:block_type]
    @block.step =Step.find(block[:step].to_i)
    save_body(block)
    block_save
  end

  def create
    authorize! :create, Block
    block = block_params
    @block = Block.new(block_type: block[:block_type], step: Step.find(block[:step].to_i))
    save_body(block)
    block_save
  end

  def destroy
    @block = Block.find(params[:id])
    authorize! :destroy, @block
    @block.destroy
    redirect_to instruction_step_path(params[:instruction_id],params[:step_id])
  end

  private

  def block_params
    params.require(:block).permit(:block_type, :body, :step)
  end

  def upload(body, block_type)
    if params[:block].key?("body")
      cloudinary_params = Cloudinary::Uploader.upload(body, :resource_type => block_type)
      @block.body = cloudinary_params["url"]
    end
  end

  def save_body(block)
    if  block[:block_type] == "text"
      @block.body = block[:body]
    end
    if block[:block_type] == "image" or block[:block_type] == "video"
      upload(block[:body], block[:block_type])
    end
  end

  def block_save
    if @block.save
      flash[:success] = t('user_form.was_update')
      redirect_to instruction_step_path(params[:instruction_id],params[:step_id])
    else
      redirect_to :back
    end
  end
end
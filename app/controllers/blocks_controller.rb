class BlocksController < ApplicationController
  # def blocks_show
  #   @blocks = Block.all
  # end

  # def show
  #   # @user_blocks = Block
  # end

  def new
    @block = Block.new
    @step = Step.find(params[:step_id].to_i)
  end

  def create
    block = block_params
    @block = Block.new(name: block[:name], block_type: block[:block_type], step: Step.find(block[:step].to_i))
    if  block[:block_type] == "text"
      @block.body = block[:body]
    end
    if block[:block_type] == "image" or block[:block_type] == "video"
      upload(block[:body], block[:block_type])
      puts "horosho"
    end
    if @block.save
      flash[:success] = t('user_form.was_update')
      redirect_to user_root_path
    else
      redirect_to :back
    end
  end

  private

  def block_params
    params.require(:block).permit(:name, :block_type, :body, :step)
  end

  def upload(body, block_type)
    if params[:block].key?("body")
      cloudinary_params = Cloudinary::Uploader.upload(body, :resource_type => block_type)
      @block.body = cloudinary_params["url"]
    end
  end
end
class InstructionsController < ApplicationController
  def create
    params = instruction_params
    params[:category] = Category.find_by(id: params[:category].to_i)
    @instruction = Instruction.new(params)
    @instruction.user_id = current_user[:id]
    if @instruction.save
      @count_links = CountLink.create(count: 0, instruction_id: @instruction.id)
     flash[:success] = t('user_form.was_update')
      render :show
    else
      render :new
    end
  end

  def show
    @instruction = Instruction.find(params[:id])
    @count_link=CountLink.find_by(instruction_id: @instruction.id)
    @count_link.count += 1
    @count_link.save
  end


  def edit
    @instruction = Instruction.find(params[:id])
  end

  def new
    @instruction = Instruction.new
  end

  def update
    @instruction = Instruction.find(params[:id])
    params = instruction_params
    params[:category] = Category.find_by(id: params[:category].to_i)
    @instruction.user_id = current_user[:id]
    if @instruction.update_attributes(params)
      redirect_to @instruction
    else
      render :edit
    end
  end

  def destroy
    @instruction = Instruction.find(params[:id])
    @instruction.destroy
    redirect_to user_root_path
  end

  def index
    @instructions = Instruction.all
  end

  private

  def instruction_params
    params.require(:instruction).permit(:name, :category, :all_tags)
  end

 end

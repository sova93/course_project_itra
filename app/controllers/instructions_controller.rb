class InstructionsController < ApplicationController
  def create
    params = instruction_params
    params[:category] = Category.find_by(id: params[:category].to_i)
    puts params[:category]
    @instruction = Instruction.new(params)
    @instruction.user_id = current_user[:id]
    if @instruction.save
      flash[:success] = t('user_form.was_update')
      render :show
    else
      puts "ploxo"
      render :new
    end
  end

  def show
    @instruction = Instruction.find(params[:id])
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

  private

  def instruction_params
    params.require(:instruction).permit(:name, :category, :all_tags)
  end
 end

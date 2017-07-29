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
    # redirect_to user_root_path
  end

  def show
    @instruction = Instruction.find(params[:id])
  end

  private

  def instruction_params
    params.require(:instruction).permit(:name, :category, :all_tags)
  end

 end

class InstructionsController < ApplicationController
  def create
    authorize! :create, Instruction

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
    authorize! :show, Instruction

    @instruction = Instruction.find(params[:id])
    @count_link = CountLink.find_by(instruction_id: @instruction.id)
    @count_link.count += 1
    @count_link.save
  end


  def edit
    authorize! :update, Instruction
    @instruction = Instruction.find(params[:id])
  end

  def new
    authorize! :create, Instruction
    @instruction = Instruction.new
  end

  def update
    authorize! :update, Instruction

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
    authorize! :destroy, @instruction
    @instruction.destroy
    redirect_to user_root_path
  end

  def index
    authorize! :index, Instruction
    @instructions = Instruction.paginate(:page => params[:page], :per_page => 10)
  end

  private

  def instruction_params
    params.require(:instruction).permit(:name, :category, :all_tags)
  end

 end

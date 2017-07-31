class StepsController < ApplicationController
  def new
    @step = Step.new()
    @step.instruction = Instruction.find(params[:instruction_id])
  end

  def edit
    @step = Step.find(params[:id])
  end

  def update
    @step = Step.find(params[:id])
    step = step_params
    step['instruction'] = Instruction.find(step['instruction'])
    if @step.update_attributes(step)
      redirect_to instruction_step_path(@step.id)
    else
      render :edit
    end
  end

  def create
     step = step_params
    @step = Step.new
    @step.name=step[:name]
    @step.instruction = Instruction.find(step[:instruction].to_i)
    if @step.save
      flash[:success] = t('user_form.was_update')
      render :show
    else
      flash[:danger] = t('user_form.error_creation')+ t('instructions.step')
      render :new
    end
  end

  def show
    @step = Step.find(params[:id])
    @step_blocks = Block.where(step_id: @step.id)
  end

  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    redirect_to instruction_path(params[:instruction_id])
  end

  private

  def step_params
    params.require(:step).permit(:name, :instruction)
  end
end

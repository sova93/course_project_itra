class StepsController < ApplicationController
  def new
    authorize! :create, Step

    @step = Step.new()
    @step.instruction = Instruction.find(params[:instruction_id])
  end

  def edit
    @step = Step.find(params[:id])
    authorize! :update, @step
  end

  def update
    @step = Step.find(params[:id])
    authorize! :update, @step
    step = step_params
    step['instruction'] = Instruction.find(step['instruction'])
    if @step.update_attributes(step)
      redirect_to instruction_step_path(@step.id)
    else
      render :edit
    end
  end

  def create
    authorize! :create, Step
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
    authorize! :show, Step
    @step = Step.find(params[:id])
    @step_blocks = Block.where(step_id: @step.id)
  end

  def destroy
    @step = Step.find(params[:id])
    authorize! :destroy, @step
    @step.destroy
    redirect_to instruction_path(params[:instruction_id])
  end

  private

  def step_params
    params.require(:step).permit(:name, :instruction)
  end
end

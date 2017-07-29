class StepsController < ApplicationController
  def new
    @step = Step.new
    @instruction = Instruction.find(params[:instruction_id].to_i)
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
  end

  private

  def step_params
    params.require(:step).permit(:name, :instruction)
  end
end

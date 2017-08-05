class HomeController < ApplicationController
  def index
    authorize! :index, Instruction
    count_update = 9
    @instructions = Instruction.order(:updated_at => 'desc')[0..count_update]
    @popular_instructions = CountLink.order(:count => 'desc')[0..count_update]
  end
end

class SearchController < ApplicationController
  def search
    @query = Instruction.search do
      fulltext params[:search]
      end
    @instructions = @query.results
  end
end

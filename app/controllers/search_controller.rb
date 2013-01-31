class SearchController < ApplicationController
  
  def index
    
  end
  
  def results
   @params = params[:search]
   search_param = "#{@params[:questionnaire_name]}*"
   @questionnaires = Questionnaire.search(search_param, :match_mode => :extended)
  end
  
end

# coding: utf-8
class QuestionsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end
  
  def destroy
    @questionnaire = Questionnaire.find(params[:questionnaire_id]) # firs in route in nested ":object_id"
    @question = @questionnaire.questions.find(params[:id])
    @question.destroy
    
    #@questionnaire = Questionnaire.find(params[:questionnaire_id]) # firs in route in nested ":object_id"
    #@questionnaire.questions.delete_all(conditions: {"_id" => params[:id]})

    respond_to do |format|
      format.html { render :nothing => true, :status => 200 }
      format.json { head :ok }
    end
  end

end

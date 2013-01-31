# coding: utf-8
class QuestionnairesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_questionnaire, :only => [:show, :fill, :submit, :answers]

  def show
    #@questionnaire.questions.build #create one object
  end
  
  def fill
    @answers = Array.new
    @questionnaire.questions.each do |q|
      answer = Answer.new
      @answers << {question: q, answer: answer}
    end
  end
  
  def submit
    answers = params[:answers].collect{ |a| a[1] }
    answers.each do |answer_param|
      
      question = @questionnaire.questions.find(answer_param[:question_id])
      question.answers.create({
        :answer => answer_param[:answer],
        :user_id => current_user.id,
        :question_id => answer_param[:question_id]
      })
      
    end    
    @questionnaire.save    
    redirect_to answers_questionnaire_path(@questionnaire)    
  end
  
  def answers
    
  end
  
  
  
  def index
    @questionnaires = @questionnaires = Questionnaire.all
  end
  
  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end
  
  def new
    @questionnaire = Questionnaire.new
    @questionnaire.questions.build #create one object
  end
  
  def create
    @questionnaire = Questionnaire.new(params[:questionnaire])
    @questionnaire.user = current_user
    if @questionnaire.save
      flash[:notice] = "Dodano ankietę."
      redirect_to user_questionnaires_path(current_user)
      #redirect_to action: 'index'
    else
      flash.now[:error] = "Nie można zapisać tej ankiety, sprawdź błędy."
      render action: 'new'
    end
  end

  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to questionnaires_path(current_user) }
      format.json { head :ok }
    end
  end
  
  def update
   @questionnaire = current_user.questionnaires.find(params[:id]) 
    respond_to do |format|
     if @questionnaire.update_attributes(params[:questionnaire])
        format.html { redirect_to questionnaire_questions_path(@questionnaire), notice: "Ankieta została zapisana!" }
        format.json { head :ok }
     else
        format.html { render action: "edit" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
     end
   end 
  end
  
  def answer
    #Answer.create(params[:answers].keys, params[:answers].values)
    # Todo, zapisywanie
  end

  private 
  
  def find_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end
  

end

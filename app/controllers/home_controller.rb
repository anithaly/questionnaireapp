class HomeController < ApplicationController
  def index
    @questionnaires = Questionnaire.limit(10).order_by([:created_at, :desc])
  end
end

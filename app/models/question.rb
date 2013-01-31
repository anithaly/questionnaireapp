class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include Mongoid::Sphinx

  field :question, type: String
  
  # Relationships
  embeds_many :answers
  embedded_in :questionnaire
  
  # Validations
  validates_presence_of :question
  
  
  #search_index(:fields => [:question], :options => {})
  
  
end
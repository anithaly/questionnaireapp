class Questionnaire
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sphinx
  
  field :title, :type => String
  field :filling_duration, :type => Integer
  field :public, :type => Boolean

  # Relationships
  embeds_many :questions
  belongs_to :user
  
  after_save :sphinx_reindex
   
   # Validations
  validates_presence_of :title
      
  accepts_nested_attributes_for :questions #for form
  
  search_index(:fields => [:title], :attributes => [])
   
   
  
  private 
  
  def sphinx_reindex
    
    pid = Process.fork
    if pid.nil? then
	exec "rake sphinx_reindex"
    else
      Process.detach(pid)
    end
    
    #Process.detach(p1)
    
  end
   
end

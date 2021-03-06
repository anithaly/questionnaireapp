class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  # DEVISE 2.0 requires this fields defined explicitly for mongoid 
    
  ## Database authenticatable
  field :email,              :type => String, :null => false
  field :encrypted_password, :type => String, :null => false
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time
  
  ## Rememberable
  field :remember_created_at, :type => Time
  
  ## Trackable
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
                     
  field :username, type: String
  field :email, type: String
  field :age,  type: Integer #, :default => 0
  
  # Relationships
  has_many :questionnaires

  
   # Validations
  validates :age, :numericality => {:allow_blank => true}
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :age
  
  def fullname
    "#{username}"
  end
  
end


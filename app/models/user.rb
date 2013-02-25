class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_and_belongs_to_many :moments

  after_create :connect_to_moments

  def connect_to_moments
  	if TempUser.where("email = ?", self.email).count > 0
  		TempUser.where("email = ?", self.email).each do |connect|
  			MomentsUsers.create(:moment_id => connect.moment_id, :user_id => self.id)
  			connect.destroy
  		end
  	end
  end

end

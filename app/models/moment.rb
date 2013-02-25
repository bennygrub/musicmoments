class Moment < ActiveRecord::Base
  attr_accessible :friends, :name, :season, :song, :year, :current_user
  attr_accessor :friends, :current_user	
  has_and_belongs_to_many :users

  before_save :sanitize_url
  after_save :friend_process, :self_moment
  validates :song, :format =>{ :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => " is not valid, it must be a youtube.com or vimeo.com url" }

  
  def friend_process
  	  self.friends.split(/, */).each do |friend|
      if User.find_by_email(friend).nil?
      	current_user = User.find(self.current_user)
        #send emails
        FriendsMailer.moment_invite(current_user, friend).deliver
      else
      	user = User.find_by_email(friend)
        MomentsUsers.create(:moment_id => self.id, :user_id => user.id)
      end
    end
  end

  def self_moment
  	MomentsUsers.create(:moment_id => self.id, :user_id => self.current_user)
  end

  def sanitize_url
	unless self.song[/^https?:\/\//] 
      self.song = 'http://' + self.song
    end
  end

end

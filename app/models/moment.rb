class Moment < ActiveRecord::Base
  attr_accessible :friends, :name, :season, :song, :year, :current_user
  attr_accessor :friends, :current_user	
  has_and_belongs_to_many :users
  has_many :temp_users

  before_save :sanitize_url
  after_save :friend_process
  after_create :self_moment

  validates :song, presence: true
  validates :song, :format =>{ :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => " is not valid, it must be a youtube.com or vimeo.com url" }
  
  def friend_process
	  current_user = User.find(self.current_user)#get the current user
    self.friends.split(/, */).each do |friend| #split the list of friends and iterate through each
      if User.find_by_email(friend).nil? #check to see if they are a not a member
        if TempUser.where("email = ? AND moment_id = ?", friend, self.id).count < 1 #check to see they already have been invited
          TempUser.create(:moment_id => self.id, :email => friend) #create temp user
          FriendsMailer.moment_invite(current_user, friend, self).deliver #send non-member invite
        end
      else # they are a member
        user = User.find_by_email(friend) #set user variable to the user object of the email
        if MomentsUsers.where("user_id = ? AND moment_id = ?", user.id, self.id).count < 1 #check to see they already have been invited
          MomentsUsers.create(:moment_id => self.id, :user_id => user.id) #create connection between user and moment
          FriendsMailer.moment_invite_member(current_user, user, self).deliver #send member invite
        end
      end
    end
  end

  def self_moment
  	MomentsUsers.create(:moment_id => self.id, :user_id => self.current_user)
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def sanitize_url
	unless self.song[/^https?:\/\//] 
      self.song = 'http://' + self.song
    end
  end

end

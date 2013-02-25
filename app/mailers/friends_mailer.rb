class FriendsMailer < ActionMailer::Base
  default from: "yomomma@musicmoments.com"

  def moment_invite(user, email, moment)
    @user = user
    @email = email
    @moment = moment 
    mail(:to => email, :subject => "#{user.email} invited you to join the music moment #{moment.name}")  
  end

  def moment_invite_member(inviter, invitee, moment)
    @inviter = inviter
    @invitee = invitee
    @moment = moment
    mail(:to => invitee.email, :subject => "#{inviter.email} invited you to join the music moment #{moment.name}")  
  end 

end

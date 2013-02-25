class FriendsMailer < ActionMailer::Base
  default from: "yomomma@musicmoments.com"

  def moment_invite(user, email)
    @user = user
    @email = email  
    mail(:to => email, :subject => "#{user.email} invited you to join a music moment")  
  end 

end

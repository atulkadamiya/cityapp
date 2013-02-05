class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def forgot(user)
  	@user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end

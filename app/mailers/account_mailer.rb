class AccountMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(account)
    @account = account
    mail :to => account.email, :subject => "Protégé Password Reset"
  end
end

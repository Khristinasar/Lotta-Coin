class PriceAlertMailer < ApplicationMailer
  default :from => 'lottacoin1@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_alert_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => '** LottaCoin **  TARGET PRICE ALERT' )
  end
end

class UserCoin < ApplicationRecord
  belongs_to :user
  belongs_to :coin

  def current_price
    data = CoinService.new.fetch([self.coin]).first
    data[1][self.coin.symbol.upcase]["USD"]["PRICE"].to_f
  end

  def alert_user
    if user_coin.text_pref == true && user.phone_number == !nil
      #send text message
    else
      #send email
      PriceAlertMailer.send_alert_email(@user).deliver

  end

end

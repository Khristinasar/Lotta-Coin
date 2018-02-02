class UserCoin < ApplicationRecord
  belongs_to :user
  belongs_to :coin

  def current_price
    data = CoinService.new.fetch([self.coin]).first
    data[1][self.coin.symbol.upcase]["USD"]["PRICE"].to_f
  end

  def alert_user
    p "Alerting User"
  end

end

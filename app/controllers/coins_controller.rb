class CoinsController < ApplicationController

  def index
      @coins = Coin.all
      api_endpoint =  "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,LTC,DASH,XMR,NXT,ETC,DOGE,ZEC&tsyms=USD"
      url = api_endpoint
      response = HTTParty.get(url)
      @data = JSON.parse(response.body)
  end

end

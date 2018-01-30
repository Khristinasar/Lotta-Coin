class CoinsController < ApplicationController

  def index
    # @coins = Coin.all
      # connect with the api's /coinsnapshot
      api_endpoint = "https://www.cryptocompare.com/api/data/coinsnapshot/"

      # find the price of BTC, in USD
      coin_symbol = "BTC"

      currency = "USD"

      query_string = "?fsym=#{coin_symbol}&tsym=#{currency}"

      url = api_endpoint + query_string
      response = HTTParty.get url

      data = JSON.parse(response.body)

      puts "************"
      p data
      puts "************"

      puts "get the price of BTC in USD..."

      btc_usd = data["Data"]["AggregatedData"]["PRICE"]
      btc_usd2 = data["Data"]["AggregatedData"]["OPEN24HOUR"]
      btc_usd3 = data["Data"]["AggregatedData"]["LOW24HOUR"]
      btc_usd4 = data["Data"]["AggregatedData"]["HIGH24HOUR"]
      @coins = [btc_usd, btc_usd2, btc_usd3, btc_usd4]

  end

end

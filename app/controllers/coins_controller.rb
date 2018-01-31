class CoinsController < ApplicationController
  def index
    # @coins = Coin.all
    # api_endpoint =  "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,LTC,DASH,XMR,NXT,ETC,DOGE,ZEC&tsyms=USD"
    # url = api_endpoint
    # response = HTTParty.get(url)
    #  @data = JSON.parse(response.body)

    # @base_url = "https://www.cryptocompare.com"
    # @coins = "https://www.cryptocompare.com/api/data/coinlist/"
    # @@coins_data = HTTParty.get(@coins)["Data"]
    # url1 = @coins
    # response1 = HTTParty.get(url1)
    # @d = JSON.parse(response1.body)

    @url = "https://www.cryptocompare.com/api/data/coinlist/"
    @coins = ["BTC","ETH","BCH","XRP","LTC","ADA","IOT","DASH","XEM","XMR","BTG","XLM","EOS","NEO","ETC","TRX","BCCOIN","QTUM","PPT","OMG"]
    @price = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{@coins.join(',')}&tsyms=USD"
    response2 = HTTParty.get(@price)
    @d1 = JSON.parse(response2.body)
  end
end

class CoinsController < ApplicationController
  def index
     @coins = Coin.all
     @q_string = []
     @coins.each do |n|
     @q_string << n.symbol
     end
     query_string = ""

     @q_string.each do |i|
       query_string << i
       query_string << ","
     end

     p query_string
     url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms="
     fiat_type = "&tsyms=USD"
     @api_endpoint = url + query_string + fiat_type
     p @api_endpoint
     url = @api_endpoint
     response = HTTParty.get(url)
     @data = JSON.parse(response.body)
  end
end

class CoinsController < ApplicationController
  def index
     @coins = Coin.all
     response = CoinService.new.fetch(@coins)
     @data = JSON.parse(response.body)
  end

  def search
     @coins = Coin.where("symbol iLIKE ? OR coinname iLIKE ?", "%#{params[:coin_term]}%","%#{params[:coin_term]}%")
     response = CoinService.new.fetch(@coins)
     @data = JSON.parse(response.body)
    render :index
  end
end

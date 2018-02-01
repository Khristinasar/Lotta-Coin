class UserCoinsController < ApplicationController
  before_action :set_user_coins, only: [:show, :edit, :update, :destroy]

  def index
    @coins = Coin.all
    @user_coins = UserCoin.all
    @q_string = []
    @user_coins.each do |n|
    @q_string << @coins.find_by(id: n.coin_id).name
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

  def show
  end

  def new
    @user_coin = UserCoin.new
  end

  def edit
  end

  def create
    if params[:coin_id].present?
      @user_coin = UserCoin.new(coin_id: params[:coin_id], user: current_user)
    else
     coins = Coin.find_by_symbol(params[:coin_symbol])
      if coins
        @user_coin = UserCoin.new(user_id: current_user, coin_id: coins)
      else
        coins = Coin.find_by_symbol(params[:coin_symbol])
          if coins.save
            @user_coin = UserCoin.new(user_id: current_user, coin_id: coins)
          else
            @user_coin = nil
          flash[:danger] = "Coin is not available"
          end
      end
    end

    respond_to do |format|
      if @user_coin.save
        flash[:success] = "Coin #{@user_coin.coin.symbol} was successfully added"
        format.html { redirect_to user_coins_path }
        format.json { render :show, status: :created, location: @user_coin }
      else
        format.html { render :new }
        format.json { render json: @user_coin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_coin.update(user_coins_params)
        flash[:success] = "Coin was successfully updated."
        format.html { redirect_to @user_coin }
        format.json { render :show, status: :ok, location: @user_coin }
      else
        format.html { render :edit }
        format.json { render json: @user_coin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_coin.destroy
    respond_to do |format|
      flash[:success] = "Coin was removed from your tracking list."
      format.html { redirect_to user_coins_path }
      format.json { head :no_content }
    end
  end

  private
    def set_user_coins
      @user_coin = UserCoin.find(params[:id])
    end

    def user_coins_params
      params.require(:user_coin).permit(:user_id, :coin_id)
    end
end

class UserCoinsController < ApplicationController
  before_action :set_user_coins, only: [:show, :edit, :update, :destroy]

  # GET /user_coinss
  # GET /user_coinss.json
  def index
    @coins = Coin.all
    @user_coins = UserCoin.all
  end

  # GET /user_coinss/1
  # GET /user_coinss/1.json
  def show
  end

  # GET /user_coinss/new
  def new
    @user_coins = UserCoin.new
  end

  # GET /user_coinss/1/edit
  def edit
  end

  # POST /user_coinss
  # POST /user_coinss.json

  def create
    if params[:coin_id].present?
      @user_coins = UserCoin.new(coin_id: params[:coin_id], user: current_user)
    else
     coins = Coin.find_by_symbol(params[:coin_symbol])
      if coins
        @user_coins = UserCoin.new(user: current_user, coins: coins)
      else
        coins = Coin.find_by_symbol(params[:coin_symbol])
          if coins.save
            @user_coins = UserCoin.new(user: current_user, coins: coins)
          else
            @user_coins = nil
          flash[:error] = "Coin is not available"
          end
      end
    end

    respond_to do |format|
      if @user_coins.save
        format.html { redirect_to my_portfolio_path,
          notice: "Coin #{@user_coins.coin.symbol} was successfully added" }
        format.json { render :show, status: :created, location: @user_coins }
      else
        format.html { render :new }
        format.json { render json: @user_coins.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_coinss/1
  # PATCH/PUT /user_coinss/1.json
  def update
    respond_to do |format|
      if @user_coins.update(user_coins_params)
        format.html { redirect_to @user_coins, notice: 'User coins was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_coins }
      else
        format.html { render :edit }
        format.json { render json: @user_coins.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_coinss/1
  # DELETE /user_coinss/1.json
  def destroy
    @user_coins.destroy
    respond_to do |format|
      format.html { redirect_to my_portfolio_path, notice: 'Coin was removed from portfolio.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_coins
      @user_coins = UserCoin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_coins_params
      params.require(:user_coins).permit(:user_id, :coin_id)
    end
end

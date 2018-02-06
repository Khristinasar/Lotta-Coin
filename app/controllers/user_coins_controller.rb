class UserCoinsController < ApplicationController

  def index
    @coins = Coin.all
    @user_coins = current_user.coins.all
    response = CoinService.new.fetch(@user_coins)
    @data = JSON.parse(response.body)
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
       format.html { redirect_to coins_path }
       flash[:danger] = "Please log in to track your coins"
       format.html { redirect_to coins_path }
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
    set_user_coin
    if @user_coin.present?
       @user_coin.destroy
    end

   respond_to do |format|
     flash[:success] = "Coin was removed from your tracking list."
     format.html { redirect_to user_coins_path }
     format.json { head :no_content }
   end
 end

 private
   def set_user_coin
     @user_coin = UserCoin.find_by(coin_id: (params[:id]))
   end

   def user_coins_params
     params.require(:user_coin).permit(:user_id, :coin_id)
   end
end

class UserCoinsController < ApplicationController
  before_action :set_user_coins, only: [:show, :edit, :update, :destroy]

  # GET /user_coins
  # GET /user_coins.json

  def index
    @coins = Coin.all
    @user_coins = UserCoin.all
    @q_string = []

    @user_coins.each do |n|
      @q_string << @coins.find_by(id: n.coin_id).name
    end
    query_string = ''

    @q_string.each do |i|
      query_string << i
      query_string << ','
    end

    p query_string

    url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms='
    fiat_type = '&tsyms=USD'

    @api_endpoint = url + query_string + fiat_type

    p @api_endpoint

    url = @api_endpoint

    response = HTTParty.get(url)
    @data = JSON.parse(response.body)
  end

  # GET /user_coins/1
  # GET /user_coins/1.json
  def show
  end

  # GET /user_coins/new
  def new
    @user_coins = UserCoin.new
  end

  # GET /user_coins/1/edit
  def edit
  end

  # POST /user_coins
  # POST /user_coins.json

  def create
    if params[:coin_id].present?
      @user_coins = UserCoin.new(coin_id: params[:coin_id], user: current_user)
    else
      coins = Coin.find_by_symbol(params[:coin_symbol])
      if coins
        @user_coins = UserCoin.new(user_id: current_user, coin_id: coins)
      else
        coins = Coin.find_by_symbol(params[:coin_symbol])
        if coins.save
          @user_coins = UserCoin.new(user_id: current_user, coin_id: coins)
        else
          @user_coins = nil
          flash[:error] = "Coin is not available"
        end
      end
    end

    respond_to do |format|
      if @user_coins.save
        format.html { redirect_to user_coins_path,
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
      format.html { redirect_to coins_users_path, notice: 'Coin was removed from wallet.' }
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



# class UserCoinsController < ApplicationController
#   before_action :set_user_coins, only: [:show, :edit, :update, :destroy]
#
#   # GET /user_coinss
#   # GET /user_coinss.json
#   def index
#     @coins = Coin.all
#     @user_coins = UserCoin.all
#     @q_string = []
#
#     @user_coins.each do |n|
#       p n.coin_id
#     p Coin.where(id: n.coin_id).name
#     @q_string << @coins.where(id: n.coin_id).fullname
#     end
#
#     query_string = ""
#     @q_string.each do |i|
#       query_string << i
#       query_string << ","
#     end
#
#     p query_string
#     url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms="
#     fiat_type = "&tsyms=USD"
#     @api_endpoint = url + query_string + fiat_type
#     p @api_endpoint
#     url = @api_endpoint
#     response = HTTParty.get(url)
#     @data = JSON.parse(response.body)
#   end
#
#   # GET /user_coinss/1
#   # GET /user_coinss/1.json
#   def show
#   end
#
#   # GET /user_coinss/new
#   def new
#     @user_coins = UserCoin.new
#   end
#
#   # GET /user_coinss/1/edit
#   def edit
#   end
#
#   # POST /user_coinss
#   # POST /user_coinss.json
#
#   def create
#     if params[:coin_id].present?
#       @user_coins = UserCoin.new(coin_id: params[:coin_id], user: current_user)
#     else
#      coins = Coin.find_by_symbol(params[:coin_symbol])
#       if coins
#         @user_coins = UserCoin.new(user_id: current_user, coin_id: coins)
#       else
#         coins = Coin.find_by_symbol(params[:coin_symbol])
#           if coins.save
#             @user_coins = UserCoin.new(user_id: current_user, coin_id: coins)
#           else
#             @user_coins = nil
#           flash[:error] = "Coin is not available"
#           end
#       end
#     end
#
#     respond_to do |format|
#       if @user_coins.save
#         format.html { redirect_to user_coins_path,
#           notice: "Coin #{@user_coins.coin.symbol} was successfully added" }
#         format.json { render :show, status: :created, location: @user_coins }
#       else
#         format.html { render :new }
#         format.json { render json: @user_coins.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /user_coinss/1
#   # PATCH/PUT /user_coinss/1.json
#   def update
#     respond_to do |format|
#       if @user_coins.update(user_coins_params)
#         format.html { redirect_to @user_coins, notice: 'User coins was successfully updated.' }
#         format.json { render :show, status: :ok, location: @user_coins }
#       else
#         format.html { render :edit }
#         format.json { render json: @user_coins.errors, status: :unprocessable_entity }
#       end
#     end
#   end

# DELETE /user_coinss/1
# DELETE /user_coinss/1.json
# def destroy
#   @user_coins.destroy
#   respond_to do |format|
#     format.html { redirect_to my_portfolio_path, notice: 'Coin was removed from portfolio.' }
#     format.json { head :no_content }
#   end
# end
#
# private
# Use callbacks to share common setup or constraints between actions.
# def set_user_coins
#   @user_coins = UserCoin.find(params[:id])
# end

# Never trust parameters from the scary internet, only allow the white list through.
#     def user_coins_params
#       params.require(:user_coins).permit(:user_id, :coin_id)
#     end
# end



# class UserCoinsController < ApplicationController
#   before_action :set_user_coins, only: [:show, :edit, :update, :destroy]
#   before_action :user_coins_params, except: [:index, :show]
# before_action :require_same_user, only: [:edit, :update, :destroy]

# def index
#    @user_coins = UserCoin.all
#  end
#
# def show
#  end

# def new
#    @user_coins = UserCoin.new
#  end

# def edit
#  end

# def create
#    @user_coins = UserCoin.new(user_coins_params)
#    @user_coins.user = current_user

#  respond_to do |format|
#     if @review.save
#       flash[:success] = "coin was successfully saved."
#       format.html { redirect_to @review.product }
#       format.json { render :show, status: :created, location: @review }
#     else
#       format.html { render :new }
#       format.json { render json: @review.errors, status: :unprocessable_entity }
#     end
#   end
# end

# def update
#    respond_to do |format|
#      if @review.update(review_params)
#        flash[:success] = "coin was successfully updated."
#        format.html { redirect_to @review }
#        format.json { render :show, status: :ok, location: @review }
#      else
#        format.html { render :edit }
#        format.json { render json: @review.errors, status: :unprocessable_entity }
#      end
#    end
#  end

# def destroy
#    @review.destroy
#    respond_to do |format|
#      flash[:success] = "coin was successfully deleted."
#      format.html { redirect_to @review.product }
#      format.json { head :no_content }
#    end
#  end
#
# private
#    def set_user_coins
#      @user_coins = UserCoin.find(params[:id])
#    end
#
#   def user_coins_params
#      params.require(:user_coins).permit(:user_id, :coin_id)
#    end

# def require_same_user
#   if current_user != @review.user and !current_user.admin?
#     flash[:danger] = 'You can only edit or delete your own article'
#     redirect_to root_path
#   end
# end
# end

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @coins = Coin.all
    @user_coins = UserCoin.where({ user_id: params[:id] })
    api_endpoint =  "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{user_coins}&tsyms=USD"
    url = api_endpoint
    response = HTTParty.get(url)
    @data = JSON.parse(response.body)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Lotta Coin, #{@user.name}!"
      redirect_to coins_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User has been deleted"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :phone_number, :text_pref, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can only edit your own account'
      redirect_to current_user
    end
  end
end

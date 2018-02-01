class UserCoinsController < ApplicationController
  before_action :set_user_coins, only: [:show, :edit, :update, :destroy]
  before_action :user_coins_params, except: [:index, :show]
  # before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @user_coins = UserCoin.all
  end

  def show
  end

  def new
    @user_coins = UserCoin.new
  end

  def edit
  end

  def create
    @user_coins = UserCoin.new(user_coins_params)
    @user_coins.user = current_user

    respond_to do |format|
      if @review.save
        flash[:success] = "coin was successfully saved."
        format.html { redirect_to @review.product }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        flash[:success] = "coin was successfully updated."
        format.html { redirect_to @review }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      flash[:success] = "coin was successfully deleted."
      format.html { redirect_to @review.product }
      format.json { head :no_content }
    end
  end

  private
    def set_user_coins
      @user_coins = UserCoin.find(params[:id])
    end

    def user_coins_params
      params.require(:user_coins).permit(:user_id, :coin_id)
    end

    # def require_same_user
    #   if current_user != @review.user and !current_user.admin?
    #     flash[:danger] = 'You can only edit or delete your own article'
    #     redirect_to root_path
    #   end
    # end
end

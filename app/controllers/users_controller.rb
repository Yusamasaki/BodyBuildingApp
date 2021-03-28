class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    if logged_in? && !current_user.admin?
      flash[:info] = 'すでにログインしています。'
      redirect_to current_user
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.save
    log_in @user
    flash[:success] = '新規作成に成功しました。'
    redirect_to user_days_url(@user)
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to users_url
    else
      render :edit  
    end
  end
  
  def destroy
    @user.destroy
    log_out
    flash[:success] = "#{@user.name}のデータを削除しました。"
    
    redirect_to root_url
  end
  
private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :meals_input, :workout]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:edit_basic_info, :update_basic_info, :meals_input]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :edit_basic_info, :update_basic_info]
  before_action :admin_or_correct_user, only: :show
  before_action :admin_false, only: :show
  
  def index
    @users = User.all
    @user = User.new
  end
  
  def show
    @users = User.all
    respond_to do |format|
      format.html
      format.csv
    end
  end
  
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
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。" 
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, 
                                   :target_body_weight, :target_body_weight_date, :admin)
    end
    
    def basic_info_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def basic_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
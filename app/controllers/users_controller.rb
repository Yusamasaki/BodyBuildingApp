class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,
                                  :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :search, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  before_action :admin_or_correct_user, only: :show
  
  def index
    @users = User.all
    @user = User.new
  end
  
  def import
    # fileはtmpに自動で一時保存される
    User.import(params[:file])
    redirect_to users_url
  end
  
  def search
    @users = User.search(params[:search]).paginate(page: params[:page])
  end
  
  def show
    @users = User.all
    @worked_sum = @attendances.where.not(started_at: nil).count
    @user = User.find(params[:id])
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
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
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
  
  def index_attendance
    @users = User.all.includes(:attendances)
  end
  
  def edit_overwork_request
   @user = User.find(params[:id])
   @day = Date.parse(params[:day])
   @attendance = Attendance.find(params[:id])
  end
      
  def update_overwork_request
    @attendance.update_attributes(overwork_request_params)
    flash[:info] = "残業申請を送信しました。"
    redirect_to users_url
  end
  
  def notice_overwork_request
    @user = User.find(params[:id])
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :employee_number,
                                   :uid, :password, :password_confirmation, :basic_time,
                                   :designated_work_start_time, :designated_work_end_time)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
    
    def overwork_request_params 
      params.require(:attendance).permit(:hour, :minute, :next_day, :superior)
    end
end
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_Confirmation, :edit, :update, :destroy,
                                  :edit_basic_info, :update_basic_info, :edit_overwork_request, :update_overwork_request,
                                  :approval_application]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :edit_basic_info, :update_basic_info, :edit_overwork_request, :update_overwork_request,
                                        :index_attendance]
  before_action :correct_user, only: [:edit, :update, :index_attendance]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info, :index_attendance]
  before_action :set_one_month, only: [:show, :show_Confirmation, :edit_overwork_request, :update_overwork_request, :approval_application]
  before_action :admin_or_correct_user, only: :show
  before_action :notice, only: :show  
  before_action :admin_false, only: :show  
  
  def index
    @users = User.all
    @user = User.new
  end
  
  def import
    # fileはtmpに自動で一時保存される
    User.import(params[:file])
    flash[:success] = '新規作成に成功しました。'
    redirect_to users_url
  end
  
  def show
    @users = User.all
    @attendance = @user.attendances.find_by(worked_on: @first_day)
    @worked_sum = @attendances.where.not(started_at: nil).count
    @attendancess = @user.attendances.where( worked_on: @first_day..@last_day).order(:worked_on).where(notice_one_month_instructor_confirmation: "2")
    respond_to do |format|
      format.html
      format.csv
    end
  end
  
  def show_Confirmation
    @users = User.all
    @attendance = @user.attendances.find_by(worked_on: @first_day)
    @worked_sum = @attendances.where.not(started_at: nil).count
    
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
    redirect_to @user
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
  
  def approval_application
    if approval_invalid? || approval_invalid_2? || approval_invalid_3? || approval_invalid_4? || approval_invalid_5?
      approval_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
      flash[:info] = "上長へ申請しました"
      redirect_to user_url
    else
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました"
      redirect_to user_url
    end
  end
  
  def edit_overwork_request
    @day = Date.parse(params[:day])
    @attendance = @user.attendances.find_by(worked_on: @day)
  end
      
  def update_overwork_request
    @day = Date.parse(params[:day])
    if overwork_invalid? || overwork_invalid_2? || overwork_invalid_3? || overwork_invalid_4? || overwork_invalid_5?
      overwork_request_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
      flash[:success] = "残業を申請しました。"
      redirect_to user_url(date: params[:date])
    else
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to user_url(date: params[:date])
    end
  end
  
  
  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :affiliation,
                                   :password, :password_confirmation, :employee_number,
                                   :uid, :basic_time, :admin, :designated_work_start_time, :designated_work_end_time)
    end
    
    def basic_info_params
      params.require(:user).permit(:name, :email, :affiliation, :basic_time,
                                   :password, :password_confirmation, :uid, :employee_number)
    end
    
    def basic_params
      params.require(:user).permit(:name, :email, :affiliation, :basic_time,
                                   :password, :password_confirmation, :uid, :employee_number)
    end
    
    def approval_params
      params.require(:user).permit(attendances: [:approval_application, :approval_application_2, :approval_application_3, :approval_application_4, :approval_application_5])[:attendances]
    end
    
    def overwork_request_params 
      params.require(:user).permit(attendances: [:expected_end_time, :next_day, :business_processing_contents, 
                                                 :instructor_confirmation, :instructor_confirmation_2, :instructor_confirmation_3, 
                                                 :instructor_confirmation_4, :instructor_confirmation_5])[:attendances]
    end
end
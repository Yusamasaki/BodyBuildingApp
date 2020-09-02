class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month, :update_overwork_request,
                                  :notice_approval_application, :update_notice_approval_application, :edit_one_month_log]
  before_action :logged_in_user, only: [:update, :edit_one_month, :notice_edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month, :edit_one_month_log]
  before_action :set_one_month, only: [:edit_one_month, :notice_approval_application, :update_notice_approval_application,
                                       :edit_one_month_log]  
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def create
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
    if @attendance.started_at.nil?
      @attendance.update_attributes(started_at: current_time)
      flash[:info] = 'おはようございます。'
    else
      flash[:danger] = 'トラブルがあり、登録出来ませんでした。'
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
      if attendances_invalid?
        attendances_params.each do |id, item|
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
        flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
        redirect_to user_url(date: params[:date])
      else
        flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
        redirect_to attendances_edit_one_month_user_url(date: params[:date])
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  
  def notice_edit_one_month
    @users = User.where.not(uid: 1).where.not(uid: 2)
    @attendance = Attendance.find(params[:id])
  end
  
  def notice_edit_one_month_B
    @users = User.where.not(uid: 1).where.not(uid: 3)
    @attendance = Attendance.find(params[:id])
  end
  
  def notice_edit_one_month_C
    @users = User.where.not(uid: 1).where.not(uid: 4) 
    @attendance = Attendance.find(params[:id])
  end
  
  def update_notice_one_month
    @user = User.find(params[:id])
    if notice_one_month_invalid? || notice_one_month_invalid_2? || notice_one_month_invalid_3? || notice_one_month_invalid_4? || notice_one_month_invalid_5?
      notice_edit_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
        flash[:success] = "【勤怠申請変更のお知らせ】を更新しました。"
        redirect_to user_url(date: params[:date])
    else
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to user_url(date: params[:date])
    end
  end
  
  def edit_one_month_log
  end
  
  def notice_overwork_request
    @users = User.where.not(uid: 1).where.not(uid: 2)
    @attendance = Attendance.find(params[:id])
  end
  
  def notice_overwork_request_B
    @users = User.where.not(uid: 1).where.not(uid: 3)
    @attendance = Attendance.find(params[:id])
  end
  
  def notice_overwork_request_C
    @users = User.where.not(uid: 1).where.not(uid: 4)
    @attendance = Attendance.find(params[:id])
  end
  
  def update_notice_overwork_request
    @user = User.find(params[:id])
      if notice_overwork_invalid? || notice_overwork_invalid_2? || notice_overwork_invalid_3? || notice_overwork_invalid_4? || notice_overwork_invalid_5?
        notice_overwork_params.each do |id, item|
        attendance = Attendance.find(id) 
        attendance.update_attributes!(item)
        end
        flash[:success] = "【残業申請のお知らせ】を更新しました。"
        redirect_to user_url(date: params[:date])
      else
        flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました"
        redirect_to user_url(date: params[:date])
      end
  end
  
  def notice_approval_application
    @users = User.where.not(uid: 1).where.not(uid: 2)
    @attendance = @user.attendances.find_by(worked_on: @first_day)
    @user = User.find(params[:id])
  end
  
  def notice_approval_application_B
    @users = User.where.not(uid: 1).where.not(uid: 3)
    @attendance = Attendance.find(params[:id])
    @user = User.find(params[:id])
  end
  
  def notice_approval_application_C
    @users = User.where.not(uid: 1).where.not(uid: 4)
    @attendance = Attendance.find(params[:id])
    @user = User.find(params[:id])
  end
  
  def update_notice_approval_application
    if notice_approval_invalid? || notice_approval_invalid_2? || notice_approval_invalid_3? || notice_approval_invalid_4? || notice_approval_invalid_5?
      notice_approval_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
      flash[:info] = "【所属長承認申請のお知らせ】を更新しました"
      redirect_to user_url
    else
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました"
      redirect_to user_url
    end
  end
  
    
  private
    # １ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :started_at_before, :finished_at_before, :started_at_before_2, :finished_at_before_2,
                                                 :started_at_before_3, :finished_at_before_3, :started_at_before_4, :finished_at_before_4, :started_at_before_5,
                                                 :finished_at_before_5, :note, :one_month_instructor_confirmation, :one_month_instructor_confirmation_2, 
                                                 :one_month_instructor_confirmation_3, :one_month_instructor_confirmation_4,
                                                 :one_month_instructor_confirmation_5])[:attendances]
    end
    
    def notice_edit_params
      params.require(:user).permit(attendances: [:notice_one_month_instructor_confirmation, :notice_one_month_instructor_confirmation_2, :notice_one_month_instructor_confirmation_3,
                                                 :notice_one_month_instructor_confirmation_4, :notice_one_month_instructor_confirmation_5,
                                                 :change_digest, :change_digest_2, :change_digest_3, :change_digest_4, :change_digest_5,])[:attendances]
    end
    
    def notice_overwork_params 
      params.require(:user).permit(attendances: [:instructor_confirmation_app, :instructor_confirmation_app_2, 
                                                 :instructor_confirmation_app_3, :instructor_confirmation_app_4, :instructor_confirmation_app_5, 
                                                 :overwork_change, :overwork_change_2, :overwork_change_3, :overwork_change_4,
                                                 :overwork_change_5])[:attendances]
    end
    
    def notice_approval_params
      params.require(:user).permit(attendances: [:approval_confirmation, :approval_confirmation_2, :approval_confirmation_3, :approval_confirmation_4, :approval_confirmation_5, 
                                                 :approval_change, :approval_change_2, :approval_change_3, :approval_change_4, :approval_change_5])[:attendances]
    end
    
    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
        @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end
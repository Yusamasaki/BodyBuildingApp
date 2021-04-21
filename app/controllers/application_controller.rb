class ApplicationController < ActionController::Base
  before_action :detect_device
  protect_from_forgery with: :exception
  include UsersHelper
  include SessionsHelper
  include DaysHelper
  include WorkoutsHelper
  
  helper_method :current_user
  
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
      
    # beforeフィルター
    
  # paramsハッシュからユーザーを取得します。
  def set_user
    @user = User.find(params[:id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
    
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    redirect_to(users_url) unless current_user?(@user) || current_user.admin?
  end
  
  def user_id_set
    @user = User.find(params[:user_id])
  end
  
  def work_day
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    
    @days = @user.days.where( worked_on: @first_day..@last_day).order(:worked_on)
    
    unless one_month.count == @days.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.days.create!(worked_on: day) }
      end
      @days = @user.days.where(worked_on: @first_day..@last_day).order(:worked_on)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
  
  def body_weight_day
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    
    @days = @user.body_weights.where( worked_on: @first_day..@last_day).order(:worked_on)
    
    unless one_month.count == @days.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.body_weights.create!(worked_on: day) }
      end
      @days = @user.body_weights.where(worked_on: @first_day..@last_day).order(:worked_on)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
  
  def day_id_set
    @day = @user.days.find(params[:day_id])
  end
  
  private
    def detect_device
      case request.user_agent
        when /iPad/
            request.variant = :mobile
        when /iPod/
            request.variant = :mobile
        when /iPhone/
            request.variant = :mobile
        when /Android/
            request.variant = :mobile
      end
    end
end
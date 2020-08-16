class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include AttendancesHelper
  
  
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
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
    
    def admin_false
      @user = User.find(params[:user_id]) if @user.blank?
      if current_user.admin?
        redirect_to(root_url)
      end
    end
    
    
    # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
  def set_one_month 
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    
    @attendances = @user.attendances.where( worked_on: @first_day..@last_day).order(:worked_on)
    
    unless one_month.count == @attendances.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.attendances.create!(worked_on: day) }
      end
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
  
  def notice
    @at_over1 = Attendance.where(instructor_confirmation: '1')
    @at_over2 = Attendance.where(instructor_confirmation: '2')
    @at_over3 = Attendance.where(instructor_confirmation: '3')
    @overwork1 = @at_over1.count
    @overwork2 = @at_over2.count
    @overwork3 = @at_over3.count
    @overwork_1 = @at_over1.where(instructor_confirmation_app: '1').or(@at_over1.where(instructor_confirmation_app: '2')).or(@at_over1.where(instructor_confirmation_app: '3')).count
    @overwork_2 = @at_over2.where(instructor_confirmation_app: '1').or(@at_over2.where(instructor_confirmation_app: '2')).or(@at_over2.where(instructor_confirmation_app: '3')).count
    @overwork_3 = @at_over3.where(instructor_confirmation_app: '1').or(@at_over3.where(instructor_confirmation_app: '2')).or(@at_over3.where(instructor_confirmation_app: '3')).count
    @overwork_1_1 = @overwork_1 == '0'
    
    @at_one_month1 = Attendance.where(one_month_instructor_confirmation: '1')
    @at_one_month2 = Attendance.where(one_month_instructor_confirmation: '2')
    @at_one_month3 = Attendance.where(one_month_instructor_confirmation: '3')
    @one_month1 = @at_one_month1.count
    @one_month2 = @at_one_month2.count
    @one_month3 = @at_one_month3.count
    @one_month_1 = @at_one_month1.where(notice_one_month_instructor_confirmation: '0').or(@at_one_month1.where(notice_one_month_instructor_confirmation: '1')).or(@at_one_month1.where(notice_one_month_instructor_confirmation: '2')).count
    @one_month_2 = @at_one_month2.where(notice_one_month_instructor_confirmation: '0').or(@at_one_month2.where(notice_one_month_instructor_confirmation: '1')).or(@at_one_month2.where(notice_one_month_instructor_confirmation: '2')).count
    @one_month_3 = @at_one_month3.where(notice_one_month_instructor_confirmation: '0').or(@at_one_month3.where(notice_one_month_instructor_confirmation: '1')).or(@at_one_month3.where(notice_one_month_instructor_confirmation: '2')).count
    
    @at_app1 = Attendance.where(approval_application: '1')
    @at_qpp2 = Attendance.where(approval_application: '2')
    @at_qpp3 = Attendance.where(approval_application: '3')
    @approval1 = @at_app1.count
    @approval2 = @at_qpp2.count
    @approval3 = @at_qpp3.count
    @approval_1 = @at_app1.where(approval_confirmation: '0').or(@at_app1.where(approval_confirmation: '1')).or(@at_app1.where(approval_confirmation: '2')).count
    @approval_2 = @at_qpp2.where(approval_confirmation: '0').or(@at_qpp2.where(approval_confirmation: '1')).or(@at_qpp2.where(approval_confirmation: '2')).count
    @approval_3 = @at_qpp3.where(approval_confirmation: '0').or(@at_qpp3.where(approval_confirmation: '1')).or(@at_qpp3.where(approval_confirmation: '2')).count
  end
  
  def import_emails
    # 登録処理前のレコード数
    current_email_count = ::Email.count
    emails = []
    # windowsで作られたファイルに対応するので、encoding: "SJIS"を付けている
    CSV.foreach(params[:emails_file].path, headers: true, encoding: "SJIS") do |row|
      emails << ::Email.new({ name: row["name"], email: row["email"] })
    end
    # importメソッドでバルクインサートできる
    ::Email.import(emails)
    # 何レコード登録できたかを返す
    ::Email.count - current_email_count
  end
  
end
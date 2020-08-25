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
      redirect_to(users_url) unless current_user?(@user) || current_user.admin?
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
    #残業申請count#
    @at_over1 = Attendance.where(instructor_confirmation: '1').count
    @at_over11 = Attendance.where(instructor_confirmation_2: '1').count
    @at_over111 = Attendance.where(instructor_confirmation_3: '1').count
    @at_over2 = Attendance.where(instructor_confirmation: '2').count
    @at_over22 = Attendance.where(instructor_confirmation_2: '2').count
    @at_over222 = Attendance.where(instructor_confirmation_3: '2').count
    @at_over3 = Attendance.where(instructor_confirmation: '3').count
    @at_over33 = Attendance.where(instructor_confirmation_2: '3').count
    @at_over333 = Attendance.where(instructor_confirmation_3: '3').count
    @at_1 = @at_over1 + @at_over11 + @at_over111
    @at_2 = @at_over2 + @at_over22 + @at_over222
    @at_3 = @at_over3 + @at_over33 + @at_over333
    #残業申請のお知らせcount#
    @overwork1 = Attendance.where(instructor_confirmation_app: '1').count
    @overwork11 = Attendance.where(instructor_confirmation_app: '2').count
    @overwork111 = Attendance.where(instructor_confirmation_app: '3').count
    @overwork2 = Attendance.where(instructor_confirmation_app_2: '1').count
    @overwork22 = Attendance.where(instructor_confirmation_app_2: '2').count
    @overwork222 = Attendance.where(instructor_confirmation_app_2: '3').count
    @overwork3 = Attendance.where(instructor_confirmation_app_3: '1').count
    @overwork33 = Attendance.where(instructor_confirmation_app_3: '2').count
    @overwork333 = Attendance.where(instructor_confirmation_app_3: '3').count
    @overwork = @overwork1 + @overwork11 + @overwork111 + @overwork2 + @overwork22 + @overwork222 + @overwork3 + @overwork33 + @overwork333
    #end#
    
    #勤怠申請count#
    @at_one_month1 = Attendance.where(one_month_instructor_confirmation: '1').count
    @at_one_month11 = Attendance.where(one_month_instructor_confirmation_2: '1').count
    @at_one_month111 = Attendance.where(one_month_instructor_confirmation_3: '1').count
    @at_one_month2 = Attendance.where(one_month_instructor_confirmation: '2').count
    @at_one_month22 = Attendance.where(one_month_instructor_confirmation_2: '2').count
    @at_one_month222 = Attendance.where(one_month_instructor_confirmation_3: '2').count
    @at_one_month3 = Attendance.where(one_month_instructor_confirmation: '3').count
    @at_one_month33 = Attendance.where(one_month_instructor_confirmation_2: '3').count
    @at_one_month333 = Attendance.where(one_month_instructor_confirmation_3: '3').count
    @at_month1 = @at_one_month1 + @at_one_month11 + @at_one_month111
    @at_month2 = @at_one_month2 + @at_one_month22 + @at_one_month222
    @at_month3 = @at_one_month3 + @at_one_month33 + @at_one_month333
    #勤怠申請のお知らせcount#
    @one_month_1 = Attendance.where(notice_one_month_instructor_confirmation: '1').count
    @one_month_11 = Attendance.where(notice_one_month_instructor_confirmation_2: '1').count
    @one_month_111 = Attendance.where(notice_one_month_instructor_confirmation_3: '1').count
    @one_month_2 = Attendance.where(notice_one_month_instructor_confirmation: '2').count
    @one_month_22 = Attendance.where(notice_one_month_instructor_confirmation_2: '2').count
    @one_month_222 = Attendance.where(notice_one_month_instructor_confirmation_3: '2').count
    @one_month_3 = Attendance.where(notice_one_month_instructor_confirmation: '3').count
    @one_month_33 = Attendance.where(notice_one_month_instructor_confirmation_2: '3').count
    @one_month_333 = Attendance.where(notice_one_month_instructor_confirmation_3: '3').count
    @month = @one_month_1 + @one_month_11 + @one_month_111 + @one_month_2 + @one_month_22 + @one_month_222 + @one_month_3 + @one_month_33 + @one_month_333
    #end#
    
    @at_app_1 = Attendance.where(approval_application: '1').count
    @at_app_11 = Attendance.where(approval_application_2: '1').count
    @at_app_111 = Attendance.where(approval_application_3: '1').count
    @at_app_1111 = Attendance.where(approval_application_4: '1').count
    @at_app_11111 = Attendance.where(approval_application_5: '1').count
    @at_app_2 = Attendance.where(approval_application: '2').count
    @at_app_22 = Attendance.where(approval_application_2: '2').count
    @at_app_222 = Attendance.where(approval_application_3: '2').count
    @at_app_2222 = Attendance.where(approval_application_4: '2').count
    @at_app_22222 = Attendance.where(approval_application_5: '2').count
    @at_app_3 = Attendance.where(approval_application: '3').count
    @at_app_33 = Attendance.where(approval_application_2: '3').count
    @at_app_333 = Attendance.where(approval_application_3: '3').count
    @at_app_3333 = Attendance.where(approval_application_4: '3').count
    @at_app_33333 = Attendance.where(approval_application_5: '3').count
    @app_1 = @at_app_1 + @at_app_11 + @at_app_111 + @at_app_1111 + @at_app_11111
    @app_2 = @at_app_2 + @at_app_22 + @at_app_222 + @at_app_2222 + @at_app_22222
    @app_3 = @at_app_3 + @at_app_33 + @at_app_333 + @at_app_3333 + @at_app_33333
    
    @approval_1 = Attendance.where(approval_confirmation: '1').count
    @approval_11 = Attendance.where(approval_confirmation_2: '1').count
    @approval_111 = Attendance.where(approval_confirmation_3: '1').count
    @approval_1111 = Attendance.where(approval_confirmation_4: '1').count
    @approval_11111 = Attendance.where(approval_confirmation_5: '1').count
    @approval_2 = Attendance.where(approval_confirmation: '2').count
    @approval_22 = Attendance.where(approval_confirmation_2: '2').count
    @approval_222 = Attendance.where(approval_confirmation_3: '2').count
    @approval_2222 = Attendance.where(approval_confirmation_4: '2').count
    @approval_22222 = Attendance.where(approval_confirmation_5: '2').count
    @approval_3 = Attendance.where(approval_confirmation: '3').count
    @approval_33 = Attendance.where(approval_confirmation_2: '3').count
    @approval_333 = Attendance.where(approval_confirmation_3: '3').count
    @approval_3333 = Attendance.where(approval_confirmation_4: '3').count
    @approval_33333 = Attendance.where(approval_confirmation_5: '3').count
    @approval = @approval_1 + @approval_11 + @approval_111 + @approval_1111 + @approval_11111 +
                @approval_2 + @approval_22 + @approval_222 + @approval_2222 + @approval_22222 + 
                @approval_3 + @approval_33 + @approval_333 + @approval_3333 + @approval_33333
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
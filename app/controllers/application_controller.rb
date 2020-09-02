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
      @at_over1111 = Attendance.where(instructor_confirmation_4: '1').count
      @at_over11111 = Attendance.where(instructor_confirmation_4: '1').count
      @at_over2 = Attendance.where(instructor_confirmation: '2').count
      @at_over22 = Attendance.where(instructor_confirmation_2: '2').count
      @at_over222 = Attendance.where(instructor_confirmation_3: '2').count
      @at_over2222 = Attendance.where(instructor_confirmation_4: '2').count
      @at_over22222 = Attendance.where(instructor_confirmation_5: '2').count
      @at_over3 = Attendance.where(instructor_confirmation: '3').count
      @at_over33 = Attendance.where(instructor_confirmation_2: '3').count
      @at_over333 = Attendance.where(instructor_confirmation_3: '3').count
      @at_over3333 = Attendance.where(instructor_confirmation_4: '3').count
      @at_over33333 = Attendance.where(instructor_confirmation_5: '3').count
      #上長Aへの残業申請#
      @at_1 = @at_over1 + @at_over11 + @at_over111 + @at_over1111 + @at_over11111
      #上長Bへの残業申請#
      @at_2 = @at_over2 + @at_over22 + @at_over222 + @at_over2222 + @at_over22222
      #上長Cへの残業申請#
      @at_3 = @at_over3 + @at_over33 + @at_over333 + @at_over3333 + @at_over33333
      
      #残業申請のお知らせcount#
      #上長A#
      @overwork_A_1 = Attendance.where(instructor_confirmation: '1').where(instructor_confirmation_app: '1').count
      @overwork_A_11 = Attendance.where(instructor_confirmation: '1').where(instructor_confirmation_app: '2').count
      @overwork_A_111 = Attendance.where(instructor_confirmation: '1').where(instructor_confirmation_app: '3').count
      @overwork_A_2 = Attendance.where(instructor_confirmation_2: '1').where(instructor_confirmation_app_2: '1').count
      @overwork_A_22 = Attendance.where(instructor_confirmation_2: '1').where(instructor_confirmation_app_2: '2').count
      @overwork_A_222 = Attendance.where(instructor_confirmation_2: '1').where(instructor_confirmation_app_2: '3').count
      @overwork_A_3 = Attendance.where(instructor_confirmation_3: '1').where(instructor_confirmation_app_3: '1').count
      @overwork_A_33 = Attendance.where(instructor_confirmation_3: '1').where(instructor_confirmation_app_3: '2').count
      @overwork_A_333 = Attendance.where(instructor_confirmation_3: '1').where(instructor_confirmation_app_3: '3').count
      @overwork_A_4 = Attendance.where(instructor_confirmation_4: '1').where(instructor_confirmation_app_4: '1').count
      @overwork_A_44 = Attendance.where(instructor_confirmation_4: '1').where(instructor_confirmation_app_4: '2').count
      @overwork_A_444 = Attendance.where(instructor_confirmation_4: '1').where(instructor_confirmation_app_4: '3').count
      @overwork_A_5 = Attendance.where(instructor_confirmation_5: '1').where(instructor_confirmation_app_5: '1').count
      @overwork_A_55 = Attendance.where(instructor_confirmation_5: '1').where(instructor_confirmation_app_5: '2').count
      @overwork_A_555 = Attendance.where(instructor_confirmation_5: '1').where(instructor_confirmation_app_5: '3').count
      @overwork_A = @overwork_A_1 + @overwork_A_11 + @overwork_A_111 + #1回目の上長からの[申請中、承認、否認]#
                    @overwork_A_2 + @overwork_A_22 + @overwork_A_222 + #2回目の上長からの[申請中、承認、否認]#
                    @overwork_A_3 + @overwork_A_33 + @overwork_A_333 + #3回目の上長からの[申請中、承認、否認]#
                    @overwork_A_4 + @overwork_A_44 + @overwork_A_444 + #4回目の上長からの[申請中、承認、否認]#
                    @overwork_A_5 + @overwork_A_55 + @overwork_A_555   #5回目の上長からの[申請中、承認、否認]#
      #上長B#
      @overwork_B_1 = Attendance.where(instructor_confirmation: '2').where(instructor_confirmation_app: '1').count
      @overwork_B_11 = Attendance.where(instructor_confirmation: '2').where(instructor_confirmation_app: '2').count
      @overwork_B_111 = Attendance.where(instructor_confirmation: '2').where(instructor_confirmation_app: '3').count
      @overwork_B_2 = Attendance.where(instructor_confirmation_2: '2').where(instructor_confirmation_app_2: '1').count
      @overwork_B_22 = Attendance.where(instructor_confirmation_2: '2').where(instructor_confirmation_app_2: '2').count
      @overwork_B_222 = Attendance.where(instructor_confirmation_2: '2').where(instructor_confirmation_app_2: '3').count
      @overwork_B_3 = Attendance.where(instructor_confirmation_3: '2').where(instructor_confirmation_app_3: '1').count
      @overwork_B_33 = Attendance.where(instructor_confirmation_3: '2').where(instructor_confirmation_app_3: '2').count
      @overwork_B_333 = Attendance.where(instructor_confirmation_3: '2').where(instructor_confirmation_app_3: '3').count
      @overwork_B_4 = Attendance.where(instructor_confirmation_4: '2').where(instructor_confirmation_app_4: '1').count
      @overwork_B_44 = Attendance.where(instructor_confirmation_4: '2').where(instructor_confirmation_app_4: '2').count
      @overwork_B_444 = Attendance.where(instructor_confirmation_4: '2').where(instructor_confirmation_app_4: '3').count
      @overwork_B_5 = Attendance.where(instructor_confirmation_5: '2').where(instructor_confirmation_app_5: '1').count
      @overwork_B_55 = Attendance.where(instructor_confirmation_5: '2').where(instructor_confirmation_app_5: '2').count
      @overwork_B_555 = Attendance.where(instructor_confirmation_5: '2').where(instructor_confirmation_app_5: '3').count
      @overwork_B = @overwork_B_1 + @overwork_B_11 + @overwork_B_111 + #1回目の上長からの[申請中、承認、否認]#
                    @overwork_B_2 + @overwork_B_22 + @overwork_B_222 + #2回目の上長からの[申請中、承認、否認]#
                    @overwork_B_3 + @overwork_B_33 + @overwork_B_333 + #3回目の上長からの[申請中、承認、否認]#
                    @overwork_B_4 + @overwork_B_44 + @overwork_B_444 + #4回目の上長からの[申請中、承認、否認]#
                    @overwork_B_5 + @overwork_B_55 + @overwork_B_555   #5回目の上長からの[申請中、承認、否認]#
      #上長C#
      @overwork_C_1 = Attendance.where(instructor_confirmation: '3').where(instructor_confirmation_app: '1').count
      @overwork_C_11 = Attendance.where(instructor_confirmation: '3').where(instructor_confirmation_app: '2').count
      @overwork_C_111 = Attendance.where(instructor_confirmation: '3').where(instructor_confirmation_app: '3').count
      @overwork_C_2 = Attendance.where(instructor_confirmation_2: '3').where(instructor_confirmation_app_2: '1').count
      @overwork_C_22 = Attendance.where(instructor_confirmation_2: '3').where(instructor_confirmation_app_2: '2').count
      @overwork_C_222 = Attendance.where(instructor_confirmation_2: '3').where(instructor_confirmation_app_2: '3').count
      @overwork_C_3 = Attendance.where(instructor_confirmation_3: '3').where(instructor_confirmation_app_3: '1').count
      @overwork_C_33 = Attendance.where(instructor_confirmation_3: '3').where(instructor_confirmation_app_3: '2').count
      @overwork_C_333 = Attendance.where(instructor_confirmation_3: '3').where(instructor_confirmation_app_3: '3').count
      @overwork_C_4 = Attendance.where(instructor_confirmation_4: '3').where(instructor_confirmation_app_4: '1').count
      @overwork_C_44 = Attendance.where(instructor_confirmation_4: '3').where(instructor_confirmation_app_4: '2').count
      @overwork_C_444 = Attendance.where(instructor_confirmation_4: '3').where(instructor_confirmation_app_4: '3').count
      @overwork_C_5 = Attendance.where(instructor_confirmation_5: '3').where(instructor_confirmation_app_5: '1').count
      @overwork_C_55 = Attendance.where(instructor_confirmation_5: '3').where(instructor_confirmation_app_5: '2').count
      @overwork_C_555 = Attendance.where(instructor_confirmation_5: '3').where(instructor_confirmation_app_5: '3').count
      @overwork_C = @overwork_C_1 + @overwork_C_11 + @overwork_C_111 + #1回目の上長からの[申請中、承認、否認]#
                    @overwork_C_2 + @overwork_C_22 + @overwork_C_222 + #2回目の上長からの[申請中、承認、否認]#
                    @overwork_C_3 + @overwork_C_33 + @overwork_C_333 + #3回目の上長からの[申請中、承認、否認]#
                    @overwork_C_4 + @overwork_C_44 + @overwork_C_444 + #4回目の上長からの[申請中、承認、否認]#
                    @overwork_C_5 + @overwork_C_55 + @overwork_C_555   #5回目の上長からの[申請中、承認、否認]#
      #end#
    
    #勤怠申請count#
    @at_one_month1 = Attendance.where(one_month_instructor_confirmation: '1').count
    @at_one_month11 = Attendance.where(one_month_instructor_confirmation_2: '1').count
    @at_one_month111 = Attendance.where(one_month_instructor_confirmation_3: '1').count
    @at_one_month1111 = Attendance.where(one_month_instructor_confirmation_4: '1').count
    @at_one_month11111 = Attendance.where(one_month_instructor_confirmation_5: '1').count
    @at_one_month2 = Attendance.where(one_month_instructor_confirmation: '2').count
    @at_one_month22 = Attendance.where(one_month_instructor_confirmation_2: '2').count
    @at_one_month222 = Attendance.where(one_month_instructor_confirmation_3: '2').count
    @at_one_month2222 = Attendance.where(one_month_instructor_confirmation_4: '2').count
    @at_one_month22222 = Attendance.where(one_month_instructor_confirmation_5: '2').count
    @at_one_month3 = Attendance.where(one_month_instructor_confirmation: '3').count
    @at_one_month33 = Attendance.where(one_month_instructor_confirmation_2: '3').count
    @at_one_month333 = Attendance.where(one_month_instructor_confirmation_3: '3').count
    @at_one_month3333 = Attendance.where(one_month_instructor_confirmation_4: '3').count
    @at_one_month33333 = Attendance.where(one_month_instructor_confirmation_5: '3').count
    @at_month1 = @at_one_month1 + @at_one_month11 + @at_one_month111 + @at_one_month1111 + @at_one_month11111
    @at_month2 = @at_one_month2 + @at_one_month22 + @at_one_month222 + @at_one_month2222 + @at_one_month22222
    @at_month3 = @at_one_month3 + @at_one_month33 + @at_one_month333 + @at_one_month3333 + @at_one_month33333
    
    #勤怠申請のお知らせcount#
    @one_month_A_1 = Attendance.where(one_month_instructor_confirmation: '1').where(notice_one_month_instructor_confirmation: '1').count
    @one_month_A_11 = Attendance.where(one_month_instructor_confirmation_2: '1').where(notice_one_month_instructor_confirmation_2: '1').count
    @one_month_A_111 = Attendance.where(one_month_instructor_confirmation_3: '1').where(notice_one_month_instructor_confirmation_3: '1').count
    @one_month_A_1111 = Attendance.where(one_month_instructor_confirmation_4: '1').where(notice_one_month_instructor_confirmation_4: '1').count
    @one_month_A_11111 = Attendance.where(one_month_instructor_confirmation_5: '1').where(notice_one_month_instructor_confirmation_5: '1').count
    @one_month_A_2 = Attendance.where(one_month_instructor_confirmation: '1').where(notice_one_month_instructor_confirmation: '2').count
    @one_month_A_22 = Attendance.where(one_month_instructor_confirmation_2: '1').where(notice_one_month_instructor_confirmation_2: '2').count
    @one_month_A_222 = Attendance.where(one_month_instructor_confirmation_3: '1').where(notice_one_month_instructor_confirmation_3: '2').count
    @one_month_A_2222 = Attendance.where(one_month_instructor_confirmation_4: '1').where(notice_one_month_instructor_confirmation_4: '2').count
    @one_month_A_22222 = Attendance.where(one_month_instructor_confirmation_5: '1').where(notice_one_month_instructor_confirmation_5: '2').count
    @one_month_A_3 = Attendance.where(one_month_instructor_confirmation: '1').where(notice_one_month_instructor_confirmation: '3').count
    @one_month_A_33 = Attendance.where(one_month_instructor_confirmation_2: '1').where(notice_one_month_instructor_confirmation_2: '3').count
    @one_month_A_333 = Attendance.where(one_month_instructor_confirmation_3: '1').where(notice_one_month_instructor_confirmation_3: '3').count
    @one_month_A_3333 = Attendance.where(one_month_instructor_confirmation_4: '1').where(notice_one_month_instructor_confirmation_4: '3').count
    @one_month_A_33333 = Attendance.where(one_month_instructor_confirmation_5: '1').where(notice_one_month_instructor_confirmation_5: '3').count
    @month_A = @one_month_A_1 + @one_month_A_11 + @one_month_A_111 + @one_month_A_1111 + @one_month_A_11111 +
               @one_month_A_2 + @one_month_A_22 + @one_month_A_222 + @one_month_A_2222 + @one_month_A_22222 +
               @one_month_A_3 + @one_month_A_33 + @one_month_A_333 + @one_month_A_3333 + @one_month_A_33333
           
    #上長B#  
    @one_month_B_1 = Attendance.where(one_month_instructor_confirmation: '2').where(notice_one_month_instructor_confirmation: '1').count
    @one_month_B_11 = Attendance.where(one_month_instructor_confirmation_2: '2').where(notice_one_month_instructor_confirmation_2: '1').count
    @one_month_B_111 = Attendance.where(one_month_instructor_confirmation_3: '2').where(notice_one_month_instructor_confirmation_3: '1').count
    @one_month_B_1111 = Attendance.where(one_month_instructor_confirmation_4: '2').where(notice_one_month_instructor_confirmation_4: '1').count
    @one_month_B_11111 = Attendance.where(one_month_instructor_confirmation_5: '2').where(notice_one_month_instructor_confirmation_5: '1').count
    @one_month_B_2 = Attendance.where(one_month_instructor_confirmation: '2').where(notice_one_month_instructor_confirmation: '2').count
    @one_month_B_22 = Attendance.where(one_month_instructor_confirmation_2: '2').where(notice_one_month_instructor_confirmation_2: '2').count
    @one_month_B_222 = Attendance.where(one_month_instructor_confirmation_3: '2').where(notice_one_month_instructor_confirmation_3: '2').count
    @one_month_B_2222 = Attendance.where(one_month_instructor_confirmation_4: '2').where(notice_one_month_instructor_confirmation_4: '2').count
    @one_month_B_22222 = Attendance.where(one_month_instructor_confirmation_5: '2').where(notice_one_month_instructor_confirmation_5: '2').count
    @one_month_B_3 = Attendance.where(one_month_instructor_confirmation: '2').where(notice_one_month_instructor_confirmation: '3').count
    @one_month_B_33 = Attendance.where(one_month_instructor_confirmation_2: '2').where(notice_one_month_instructor_confirmation_2: '3').count
    @one_month_B_333 = Attendance.where(one_month_instructor_confirmation_3: '2').where(notice_one_month_instructor_confirmation_3: '3').count
    @one_month_B_3333 = Attendance.where(one_month_instructor_confirmation_4: '2').where(notice_one_month_instructor_confirmation_4: '3').count
    @one_month_B_33333 = Attendance.where(one_month_instructor_confirmation_5: '2').where(notice_one_month_instructor_confirmation_5: '3').count
    @month_B = @one_month_B_1 + @one_month_B_11 + @one_month_B_111 + @one_month_B_1111 + @one_month_B_11111 +
               @one_month_B_2 + @one_month_B_22 + @one_month_B_222 + @one_month_B_2222 + @one_month_B_22222 +
               @one_month_B_3 + @one_month_B_33 + @one_month_B_333 + @one_month_B_3333 + @one_month_B_33333
    
    @one_month_C_1 = Attendance.where(one_month_instructor_confirmation: '3').where(notice_one_month_instructor_confirmation: '1').count
    @one_month_C_11 = Attendance.where(one_month_instructor_confirmation_2: '3').where(notice_one_month_instructor_confirmation_2: '1').count
    @one_month_C_111 = Attendance.where(one_month_instructor_confirmation_3: '3').where(notice_one_month_instructor_confirmation_3: '1').count
    @one_month_C_1111 = Attendance.where(one_month_instructor_confirmation_4: '3').where(notice_one_month_instructor_confirmation_4: '1').count
    @one_month_C_11111 = Attendance.where(one_month_instructor_confirmation_5: '3').where(notice_one_month_instructor_confirmation_5: '1').count
    @one_month_C_2 = Attendance.where(one_month_instructor_confirmation: '3').where(notice_one_month_instructor_confirmation: '2').count
    @one_month_C_22 = Attendance.where(one_month_instructor_confirmation_2: '3').where(notice_one_month_instructor_confirmation_2: '2').count
    @one_month_C_222 = Attendance.where(one_month_instructor_confirmation_3: '3').where(notice_one_month_instructor_confirmation_3: '2').count
    @one_month_C_2222 = Attendance.where(one_month_instructor_confirmation_4: '3').where(notice_one_month_instructor_confirmation_4: '2').count
    @one_month_C_22222 = Attendance.where(one_month_instructor_confirmation_5: '3').where(notice_one_month_instructor_confirmation_5: '2').count
    @one_month_C_3 = Attendance.where(one_month_instructor_confirmation: '3').where(notice_one_month_instructor_confirmation: '3').count
    @one_month_C_33 = Attendance.where(one_month_instructor_confirmation_2: '3').where(notice_one_month_instructor_confirmation_2: '3').count
    @one_month_C_333 = Attendance.where(one_month_instructor_confirmation_3: '3').where(notice_one_month_instructor_confirmation_3: '3').count
    @one_month_C_3333 = Attendance.where(one_month_instructor_confirmation_4: '3').where(notice_one_month_instructor_confirmation_4: '3').count
    @one_month_C_33333 = Attendance.where(one_month_instructor_confirmation_5: '3').where(notice_one_month_instructor_confirmation_5: '3').count
    @month_C = @one_month_C_1 + @one_month_C_11 + @one_month_C_111 + @one_month_C_1111 + @one_month_C_11111 +
               @one_month_C_2 + @one_month_C_22 + @one_month_C_222 + @one_month_C_2222 + @one_month_C_22222 +
               @one_month_C_3 + @one_month_C_33 + @one_month_C_333 + @one_month_C_3333 + @one_month_C_33333
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
    
    @approval_A_1 = Attendance.where(approval_application: '1').where(approval_confirmation: '1').count
    @approval_A_11 = Attendance.where(approval_application_2: '1').where(approval_confirmation_2: '1').count
    @approval_A_111 = Attendance.where(approval_application_3: '1').where(approval_confirmation_3: '1').count
    @approval_A_1111 = Attendance.where(approval_application_4: '1').where(approval_confirmation_4: '1').count
    @approval_A_11111 = Attendance.where(approval_application_5: '1').where(approval_confirmation_5: '1').count
    @approval_A_2 = Attendance.where(approval_application: '1').where(approval_confirmation: '2').count
    @approval_A_22 = Attendance.where(approval_application_2: '1').where(approval_confirmation_2: '2').count
    @approval_A_222 = Attendance.where(approval_confirmation_3: '1').count
    @approval_A_2222 = Attendance.where(approval_application_4: '1').where(approval_confirmation_4: '2').count
    @approval_A_22222 = Attendance.where(approval_application_5: '1').where(approval_confirmation_5: '2').count
    @approval_A_3 = Attendance.where(approval_application: '1').where(approval_confirmation: '3').count
    @approval_A_33 = Attendance.where(approval_application_2: '1').where(approval_confirmation_2: '3').count
    @approval_A_333 = Attendance.where(approval_application_3: '1').where(approval_confirmation_3: '3').count
    @approval_A_3333 = Attendance.where(approval_application_4: '1').where(approval_confirmation_4: '3').count
    @approval_A_33333 = Attendance.where(approval_application_5: '1').where(approval_confirmation_5: '3').count
    @approval_A = @approval_A_1 + @approval_A_11 + @approval_A_111 + @approval_A_1111 + @approval_A_11111 +
                  @approval_A_2 + @approval_A_22 + @approval_A_222 + @approval_A_2222 + @approval_A_22222 + 
                  @approval_A_3 + @approval_A_33 + @approval_A_333 + @approval_A_3333 + @approval_A_33333
    
    @approval_B_1 = Attendance.where(approval_application: '2').where(approval_confirmation: '1').count
    @approval_B_11 = Attendance.where(approval_application_2: '2').where(approval_confirmation_2: '1').count
    @approval_B_111 = Attendance.where(approval_application_3: '2').where(approval_confirmation_3: '1').count
    @approval_B_1111 = Attendance.where(approval_application_4: '2').where(approval_confirmation_4: '1').count
    @approval_B_11111 = Attendance.where(approval_application_5: '2').where(approval_confirmation_5: '1').count
    @approval_B_2 = Attendance.where(approval_application: '2').where(approval_confirmation: '2').count
    @approval_B_22 = Attendance.where(approval_application_2: '2').where(approval_confirmation_2: '2').count
    @approval_B_222 = Attendance.where(approval_confirmation_3: '2').count
    @approval_B_2222 = Attendance.where(approval_application_4: '2').where(approval_confirmation_4: '2').count
    @approval_B_22222 = Attendance.where(approval_application_5: '2').where(approval_confirmation_5: '2').count
    @approval_B_3 = Attendance.where(approval_application: '2').where(approval_confirmation: '3').count
    @approval_B_33 = Attendance.where(approval_application_2: '2').where(approval_confirmation_2: '3').count
    @approval_B_333 = Attendance.where(approval_application_3: '2').where(approval_confirmation_3: '3').count
    @approval_B_3333 = Attendance.where(approval_application_4: '2').where(approval_confirmation_4: '3').count
    @approval_B_33333 = Attendance.where(approval_application_5: '2').where(approval_confirmation_5: '3').count
    @approval_B = @approval_B_1 + @approval_B_11 + @approval_B_111 + @approval_B_1111 + @approval_B_11111 +
                  @approval_B_2 + @approval_B_22 + @approval_B_222 + @approval_B_2222 + @approval_B_22222 + 
                  @approval_B_3 + @approval_B_33 + @approval_B_333 + @approval_B_3333 + @approval_B_33333
    
    @approval_C_1 = Attendance.where(approval_application: '3').where(approval_confirmation: '1').count
    @approval_C_11 = Attendance.where(approval_application_2: '3').where(approval_confirmation_2: '1').count
    @approval_C_111 = Attendance.where(approval_application_3: '3').where(approval_confirmation_3: '1').count
    @approval_C_1111 = Attendance.where(approval_application_4: '3').where(approval_confirmation_4: '1').count
    @approval_C_11111 = Attendance.where(approval_application_5: '3').where(approval_confirmation_5: '1').count
    @approval_C_2 = Attendance.where(approval_application: '3').where(approval_confirmation: '2').count
    @approval_C_22 = Attendance.where(approval_application_2: '3').where(approval_confirmation_2: '2').count
    @approval_C_222 = Attendance.where(approval_application_3: '3').where(approval_confirmation_3: '3').count
    @approval_C_2222 = Attendance.where(approval_application_4: '3').where(approval_confirmation_4: '2').count
    @approval_C_22222 = Attendance.where(approval_application_5: '3').where(approval_confirmation_5: '2').count
    @approval_C_3 = Attendance.where(approval_application: '3').where(approval_confirmation: '3').count
    @approval_C_33 = Attendance.where(approval_application_2: '3').where(approval_confirmation_2: '3').count
    @approval_C_333 = Attendance.where(approval_application_3: '3').where(approval_confirmation_3: '3').count
    @approval_C_3333 = Attendance.where(approval_application_4: '3').where(approval_confirmation_4: '3').count
    @approval_C_33333 = Attendance.where(approval_application_5: '3').where(approval_confirmation_5: '3').count
    @approval_C = @approval_C_1 + @approval_C_11 + @approval_C_111 + @approval_C_1111 + @approval_C_11111 +
                  @approval_C_2 + @approval_C_22 + @approval_C_222 + @approval_C_2222 + @approval_C_22222 + 
                  @approval_C_3 + @approval_C_33 + @approval_C_333 + @approval_C_3333 + @approval_C_33333
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
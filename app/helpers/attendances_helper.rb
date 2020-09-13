module AttendancesHelper

  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  
  # 出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))  
  end
  
  def working_times_over(expected, designated)
    format("%.2f", (((designated - expected) / 60) / 60.0))  
  end
  
  def current_time
    Time.new(
      Time.now.year,
      Time.now.month,
      Time.now.day,
      Time.now.hour,
      Time.now.min, 0
    )
  end
  
  # 不正な値があるか確認する
  def attendances_invalid?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at_before].blank? && item[:finished_at_before].blank? && item[:one_month_instructor_confirmation].blank?
        next
      elsif item[:started_at_before].blank? || item[:finished_at_before].blank? || item[:one_month_instructor_confirmation].blank?
        attendances = false
        break
      elsif item[:started_at_before] > item[:finished_at_before]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  def attendances_invalid_2?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at_before_2].blank? && item[:finished_at_before_2].blank? && item[:one_month_instructor_confirmation_2].blank?
        next
      elsif item[:started_at_before_2].blank? || item[:finished_at_before_2].blank? || item[:one_month_instructor_confirmation_2].blank?
        attendances = false
        break
      elsif item[:started_at_before_2] > item[:finished_at_before_2]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  def attendances_invalid_3?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at_before_3].blank? && item[:finished_at_before_3].blank? && item[:one_month_instructor_confirmation_3].blank?
        next
      elsif item[:started_at_before_3].blank? || item[:finished_at_before_3].blank? || item[:one_month_instructor_confirmation_3].blank?
        attendances = false
        break
      elsif item[:started_at_before_3] > item[:finished_at_before_3]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  def attendances_invalid_4?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at_before_4].blank? && item[:finished_at_before_4].blank? && item[:one_month_instructor_confirmation_4].blank?
        next
      elsif item[:started_at_before_4].blank? || item[:finished_at_before_4].blank? || item[:one_month_instructor_confirmation_4].blank?
        attendances = false
        break
      elsif item[:started_at_before_4] > item[:finished_at_before_4]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  def attendances_invalid_5?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at_before_5].blank? && item[:finished_at_before_5].blank? && item[:one_month_instructor_confirmation_5].blank?
        next
      elsif item[:started_at_before_5].blank? || item[:finished_at_before_5].blank? || item[:one_month_instructor_confirmation_5].blank?
        attendances = false
        break
      elsif item[:started_at_before_5] > item[:finished_at_before_5]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  #勤怠お知らせ1回目#
  def notice_one_month_invalid?
    notice_one_month = true
    notice_edit_params.each do |id, item|
      if item[:notice_one_month_instructor_confirmation].blank? && item[:change_digest] == '0'
        next
      elsif item[:notice_one_month_instructor_confirmation].blank? || item[:change_digest] == '0'
        notice_one_month = false
        break
      end
    end
    return notice_one_month
  end
  #勤怠お知らせ2回目#
  def notice_one_month_invalid_2?
    notice_one_month = true
    notice_edit_params.each do |id, item|
      if item[:notice_one_month_instructor_confirmation_2].blank? && item[:change_digest_2] == '0'
        next
      elsif item[:notice_one_month_instructor_confirmation_2].blank? || item[:change_digest_2] == '0'
        notice_one_month = false
        break
      end
    end
    return notice_one_month
  end
  #勤怠お知らせ3回目#
  def notice_one_month_invalid_3?
    notice_one_month = true
    notice_edit_params.each do |id, item|
      if item[:notice_one_month_instructor_confirmation_3].blank? && item[:change_digest_3] == '0'
        
        next
      elsif item[:notice_one_month_instructor_confirmation_3].blank? || item[:change_digest_3] == '0'
        notice_one_month = false
        break
      end
    end
    return notice_one_month
  end
  #勤怠お知らせ4回目#
  def notice_one_month_invalid_4?
    notice_one_month = true
    notice_edit_params.each do |id, item|
      if item[:notice_one_month_instructor_confirmation_4].blank? && item[:change_digest_4] == '0'
        next
      elsif item[:notice_one_month_instructor_confirmation_4].blank? || item[:change_digest_4] == '0'
        notice_one_month = false
        break
      end
    end
    return notice_one_month
  end
  #勤怠お知らせ5回目#
  def notice_one_month_invalid_5?
    notice_one_month = true
    notice_edit_params.each do |id, item|
      if item[:notice_one_month_instructor_confirmation_5].blank? && item[:change_digest_5] == '0'
        next
      elsif item[:notice_one_month_instructor_confirmation_5].blank? || item[:change_digest_5] == '0'
        notice_one_month = false
        break
      end
    end
    return notice_one_month
  end
  
  #残業お知らせ1回目#
  def notice_overwork_invalid?
    notice_overwork = true
    notice_overwork_params.each do |id, item|
      if item[:instructor_confirmation_app].blank? && item[:overwork_change] == '0'
        next
      elsif item[:instructor_confirmation_app].blank? || item[:overwork_change] == '0'
        notice_overwork = false
        break
      end
    end
    return notice_overwork
  end
  #残業お知らせ2回目#
  def notice_overwork_invalid_2?
    notice_overwork = true
    notice_overwork_params.each do |id, item|
      if item[:instructor_confirmation_app_2].blank? && item[:overwork_change_2] == '0'
        next
      elsif item[:instructor_confirmation_app_2].blank? || item[:overwork_change_2] == '0'
        notice_overwork = false
        break
      end
    end
    return notice_overwork
  end
  #残業お知らせ3回目#
  def notice_overwork_invalid_3?
    notice_overwork = true
    notice_overwork_params.each do |id, item|
      if item[:instructor_confirmation_app_3].blank? && item[:overwork_change_3] == '0'
        next
      elsif item[:instructor_confirmation_app_3].blank? || item[:overwork_change_3] == '0'
        notice_overwork = false
        break
        
      end
    end
    return notice_overwork
  end
  #残業お知らせ4回目#
  def notice_overwork_invalid_4?
    notice_overwork = true
    notice_overwork_params.each do |id, item|
      if    item[:instructor_confirmation_app_4].blank? && item[:overwork_change_4] == '0'
        next
      elsif item[:instructor_confirmation_app_4].blank? || item[:overwork_change_4] == '0'
        notice_overwork = false
        break
      end
    end
    return notice_overwork
  end
  #残業お知らせ5回目#
  def notice_overwork_invalid_5?
    notice_overwork = true
    notice_overwork_params.each do |id, item|
      if    item[:instructor_confirmation_app_5].blank? && item[:overwork_change_5] == '0'
        next
      elsif item[:instructor_confirmation_app_5].blank? || item[:overwork_change_5] == '0'
        notice_overwork = false
        break
      end
    end
    return notice_overwork
  end
  
  #所属長承認お知らせ1回目#
  def approval_invalid?
    approval = true
    approval_params.each do |id, item|
      if item[:approval_application].blank?
        approval = false
        break
      end
    end
    return approval
  end
  #所属長承認お知らせ2回目#
  def approval_invalid_2?
    approval = true
    approval_params.each do |id, item|
      if item[:approval_application_2].blank?
        approval = false
        break
      end
    end
    return approval
  end
  #所属長承認お知らせ3回目#
  def approval_invalid_3?
    approval = true
    approval_params.each do |id, item|
      if item[:approval_application_3].blank?
        approval = false
        break
      end
    end
    return approval
  end
  #所属長承認お知らせ4回目#
  def approval_invalid_4?
    approval = true
    approval_params.each do |id, item|
      if item[:approval_application_4].blank?
        approval = false
        break
      end
    end
    return approval
  end
  #所属長承認お知らせ5回目#
  def approval_invalid_5?
    approval = true
    approval_params.each do |id, item|
      if item[:approval_application_5].blank?
        approval = false
        break
      end
      
    end
    return approval
  end
  
  #所属長承認申請1回目#
  def notice_approval_invalid?
    notice_approval = true
    notice_approval_params.each do |id, item|
      if item[:approval_confirmation].blank? && item[:approval_change] == '0'
        next
      elsif item[:approval_confirmation].blank? || item[:approval_change] == '0'
        notice_approval = false
        break
      end
    end
    return notice_approval
  end
  #所属長承認申請2回目#
  def notice_approval_invalid_2?
    notice_approval = true
    notice_approval_params.each do |id, item|
      if item[:approval_confirmation_2].blank? && item[:approval_change_2] == '0'
        next
      elsif item[:approval_confirmation_2].blank? || item[:approval_change_2] == '0'
        notice_approval = false
        break
      end
    end
    return notice_approval
  end
  #所属長承認申請3回目#
  def notice_approval_invalid_3?
    notice_approval = true
    notice_approval_params.each do |id, item|
      if item[:approval_confirmation_3].blank? && item[:approval_change_3] == '0'
        next
      elsif item[:approval_confirmation_3].blank? || item[:approval_change_3] == '0'
        notice_approval = false
        break
      end
    end
    return notice_approval
  end
  #所属長承認申請4回目#
  def notice_approval_invalid_4?
    notice_approval = true
    notice_approval_params.each do |id, item|
      if item[:approval_confirmation_4].blank? && item[:approval_change_4] == '0'
        next
      elsif item[:approval_confirmation_4].blank? || item[:approval_change_4] == '0'
        notice_approval = false
        break
      end
    end
    return notice_approval
  end
  #所属長承認申請5回目#
  def notice_approval_invalid_5?
    notice_approval = true
    notice_approval_params.each do |id, item|
      if item[:approval_confirmation_5].blank? && item[:approval_change_5] == '0'
        next
      elsif item[:approval_confirmation_5].blank? || item[:approval_change_5] == '0'
        notice_approval = false
        break
      end
    end
    return notice_approval
  end
  
  def overwork_invalid?
    overwork = true
    overwork_request_params.each do |id, item|
      if item[:instructor_confirmation].blank? && item[:expected_end_time].nil?
        next
      elsif item[:instructor_confirmation].blank?
        overwork = false
        break
      elsif item[:expected_end_time].blank?
        overwork = false
        break 
      elsif item[:expected_end_time].present? && item[:next_day] == '1' && item[:expected_end_time] >= @user.designated_work_end_time
        overwork = false
        break 
      end
    end
    return overwork
  end
  
  def overwork_invalid_2?
    overwork = true
    overwork_request_params.each do |id, item|
      if item[:instructor_confirmation_2].blank? && item[:expected_end_time].nil?
        next
      elsif item[:instructor_confirmation_2].blank?
        overwork = false
        break
      elsif item[:expected_end_time].blank?
        overwork = false
        break 
      elsif item[:expected_end_time].present? && item[:next_day] == '1' && item[:expected_end_time] >= @user.designated_work_end_time
        overwork = false
        break 
      end
    end
    return overwork
  end
  
  def overwork_invalid_3?
    overwork = true
    overwork_request_params.each do |id, item|
      if item[:instructor_confirmation_3].blank? && item[:expected_end_time].nil?
        next
      elsif item[:instructor_confirmation_3].blank?
        overwork = false
        break
      elsif item[:expected_end_time].blank?
        overwork = false
        break 
      elsif item[:expected_end_time].present? && item[:next_day] == '1' && item[:expected_end_time] >= @user.designated_work_end_time
        overwork = false
        break 
      end
    end
    return overwork
  end
  
  def overwork_invalid_4?
    overwork = true
    overwork_request_params.each do |id, item|
      if item[:instructor_confirmation_4].blank? && item[:expected_end_time].nil?
        next
      elsif item[:instructor_confirmation_4].blank?
        overwork = false
        break
      elsif item[:expected_end_time].blank?
        overwork = false
        break 
      elsif item[:expected_end_time].present? && item[:next_day] == '1' && item[:expected_end_time] >= @user.designated_work_end_time
        overwork = false
        break 
      end
    end
    return overwork
  end
  
  def overwork_invalid_5?
    overwork = true
    overwork_request_params.each do |id, item|
      if item[:instructor_confirmation_5].blank? && item[:expected_end_time].nil?
        next
      elsif item[:instructor_confirmation_5].blank?
        overwork = false
        break
      elsif item[:expected_end_time].blank?
        overwork = false
        break 
      elsif item[:expected_end_time].present? && item[:next_day] == '1' && item[:expected_end_time] >= @user.designated_work_end_time
        overwork = false
        break 
      end
    end
    return overwork
  end
  
  def user_attendances_month_date
    @user.attendances.where('worked_on >= ? and worked_on <= ?', @first_day, @last_day).order('worked_on')
  end
end
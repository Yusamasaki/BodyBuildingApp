module UsersHelper
  
  # 勤怠基本情報を指定のフォーマットで返します。 
  def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
  
  def after_hours(expected_end_time, designated_work_end_time)
    format("%.2f", (((designated_work_end_time - expected_end_time) / 60) / 60.0))
  end
  
end

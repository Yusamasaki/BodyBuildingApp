require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(日付 出社 退社)
  csv << csv_column_names
  @attendancess.each do |day|
    if day.one_month_instructor_confirmation.blank? && day.notice_one_month_instructor_confirmation.blank?
      column_values = [
        day.worked_on,
        day.started_at,
        day.finished_at
      ]
    elsif day.notice_one_month_instructor_confirmation.present? && day.one_month_instructor_confirmation_2.blank?
      column_values = [
        day.worked_on,
        day.started_at_before,
        day.finished_at_before
      ]
    elsif day.notice_one_month_instructor_confirmation_2.present? && day.one_month_instructor_confirmation_3.blank?
      column_values = [
        day.worked_on,
        day.started_at_before_2,
        day.finished_at_before_2
      ]
    elsif day.notice_one_month_instructor_confirmation_3.present? && day.one_month_instructor_confirmation_4.blank?
      column_values = [
        day.worked_on,
        day.started_at_before_3,
        day.finished_at_before_3
      ]
    elsif day.notice_one_month_instructor_confirmation_4.present? && day.one_month_instructor_confirmation_5.blank?
      column_values = [
        day.worked_on,
        day.started_at_before_4,
        day.finished_at_before_4
      ]
    else
      column_values = [
        day.worked_on,
        day.started_at_before_5,
        day.finished_at_before_5
      ]
    end
    csv << column_values
  end
end
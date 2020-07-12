require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(worked_on started_at finished_at note expected_end_time business_processing_contents)
  csv << csv_column_names
  @attendances.each do |day|
    column_values = [
      day.worked_on,
      day.started_at,
      day.finished_at,
      day.note,
      day.expected_end_time,
      day.business_processing_contents
    ]
    csv << column_values
  end
end
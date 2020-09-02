class AddEditOverworkRequestToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column  :attendances, :expected_end_time, :datetime
    add_column  :attendances, :next_day, :string
    add_column  :attendances, :business_processing_contents, :string
    add_column  :attendances, :instructor_confirmation, :string
    add_column  :attendances, :instructor_confirmation_2, :string
    add_column  :attendances, :instructor_confirmation_3, :string
    add_column  :attendances, :instructor_confirmation_4, :string
    add_column  :attendances, :instructor_confirmation_5, :string
    add_column  :attendances, :instructor_confirmation_app, :string
    add_column  :attendances, :instructor_confirmation_app_2, :string
    add_column  :attendances, :instructor_confirmation_app_3, :string
    add_column  :attendances, :instructor_confirmation_app_4, :string
    add_column  :attendances, :instructor_confirmation_app_5, :string
  end
end

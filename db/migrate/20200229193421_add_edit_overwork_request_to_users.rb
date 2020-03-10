class AddEditOverworkRequestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column  :users, :expected_end_time, :datetime, default: Time.current.change(hour: 10, min: 0, sec: 0)
    add_column  :users, :next_day, :string
    add_column  :users, :business_processing_contents, :string
    add_column  :users, :instructor_confirmation, :string
  end
end

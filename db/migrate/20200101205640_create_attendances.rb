class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :started_at_before
      t.datetime :finished_at_before
      t.string :note
      t.string :one_month_instructor_confirmation
      t.string :one_month_instructor_confirmation_B
      t.string :one_month_instructor_confirmation_C
      t.string :notice_one_month_instructor_confirmation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

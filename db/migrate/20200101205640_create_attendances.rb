class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :started_at_before
      t.datetime :started_at_before_2
      t.datetime :started_at_before_3
      t.datetime :started_at_before_4
      t.datetime :started_at_before_5
      t.datetime :finished_at_before
      t.datetime :finished_at_before_2
      t.datetime :finished_at_before_3
      t.datetime :finished_at_before_4
      t.datetime :finished_at_before_5
      t.string :note
      t.string :one_month_instructor_confirmation
      t.string :one_month_instructor_confirmation_2
      t.string :one_month_instructor_confirmation_3
      t.string :one_month_instructor_confirmation_4
      t.string :one_month_instructor_confirmation_5
      t.string :notice_one_month_instructor_confirmation
      t.string :notice_one_month_instructor_confirmation_2
      t.string :notice_one_month_instructor_confirmation_3
      t.string :notice_one_month_instructor_confirmation_4
      t.string :notice_one_month_instructor_confirmation_5
      t.string :change_digest
      t.string :change_digest_2
      t.string :change_digest_3
      t.string :change_digest_4
      t.string :change_digest_5
      t.string :overwork_change
      t.string :overwork_change_2
      t.string :overwork_change_3
      t.string :overwork_change_4
      t.string :overwork_change_5
      t.string :approval_change
      t.string :approval_change_2
      t.string :approval_change_3
      t.string :approval_change_4
      t.string :approval_change_5
      t.string :approval_confirmation
      t.string :approval_confirmation_2
      t.string :approval_confirmation_3
      t.string :approval_confirmation_4
      t.string :approval_confirmation_5
      t.string :approval_application
      t.string :approval_application_2
      t.string :approval_application_3
      t.string :approval_application_4
      t.string :approval_application_5
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

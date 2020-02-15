class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.datetime :started_at
      t.datetime :finished_at
      t.string :note
      t.references :user, foreign_key: true
      t.datetime :hour
      t.datetime :minute
      t.date :next_day
      t.string :superior
      
      t.timestamps
    end
  end
end

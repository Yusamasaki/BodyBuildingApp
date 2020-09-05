class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :designated_work_start_time, default: Time.current.change(hour: 10, min: 0, sec: 0)
      t.datetime :designated_work_end_time, default: Time.current.change(hour: 19, min: 0, sec: 0)
      
      t.timestamps
    end
  end
end

class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.date :worked_on
      t.string :body_part
      
      t.datetime :start_time
      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end

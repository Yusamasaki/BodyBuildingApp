class CreateWorkouts < ActiveRecord::Migration[5.1]
  def change
    create_table :workouts do |t|
      t.date :worked_on
      t.string :body_part
      t.string :traning_event
      t.string :target_muscle
      t.integer :traning_set
      t.string :traning_kg
      t.string :traning_rep
      t.string :note
      
      t.references :user, foreign_key: true
      t.references :day, foreign_key: true
      
      t.timestamps
    end
  end
end

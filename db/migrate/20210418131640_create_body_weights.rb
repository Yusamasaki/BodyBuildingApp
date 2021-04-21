class CreateBodyWeights < ActiveRecord::Migration[5.1]
  def change
    create_table :body_weights do |t|
      t.date :worked_on
      
      t.string :weight
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

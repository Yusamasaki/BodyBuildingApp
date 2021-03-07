class CreateTraningMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :traning_menus do |t|

      t.string :traning_event
      t.string :body_part
      t.string :target_muscle
      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end

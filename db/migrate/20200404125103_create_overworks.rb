class CreateOverworks < ActiveRecord::Migration[5.1]
  def change
    create_table :overworks do |t|
      
      t.timestamps
    end
  end
end

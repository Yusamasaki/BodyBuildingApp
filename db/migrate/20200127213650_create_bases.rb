class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.string :basename
      t.string :basenumber
      t.string :baseinfo

      t.timestamps
    end
  end
end

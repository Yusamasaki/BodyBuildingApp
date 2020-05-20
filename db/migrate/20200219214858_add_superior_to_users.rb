class AddSuperiorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :superior, :boolean, default: false
    add_column :users, :superiorA, :boolean, default: false
    add_column :users, :superiorB, :boolean, default: false
    add_column :users, :superiorC, :boolean, default: false
    add_column :users, :generalA, :boolean, default: false
    add_column :users, :generalB, :boolean, default: false
  end
end

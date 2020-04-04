class AddAppApprovalApplicationToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :approval_application, :string
    add_column :attendances, :approval_confirmation, :string
  end
end

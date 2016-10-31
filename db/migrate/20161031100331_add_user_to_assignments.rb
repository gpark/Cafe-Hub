class AddUserToAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :user, index: true, foreign_key: true
    add_reference :assignments, :facility, index: true, foreign_key: true
    add_reference :assignments, :assignments_week, index: true, foreign_key: true
  end
end

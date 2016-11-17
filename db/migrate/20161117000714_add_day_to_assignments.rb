class AddDayToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :day, :string
    add_column :assignments, :start_time, :string
    add_column :assignments, :end_time, :string
  end
end

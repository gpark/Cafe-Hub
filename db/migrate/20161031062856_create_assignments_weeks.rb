class CreateAssignmentsWeeks < ActiveRecord::Migration
  def change
    create_table :assignments_weeks do |t|
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end

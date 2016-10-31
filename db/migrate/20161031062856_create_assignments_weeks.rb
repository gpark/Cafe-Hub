class CreateAssignmentsWeeks < ActiveRecord::Migration
  def change
    create_table :assignments_weeks do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

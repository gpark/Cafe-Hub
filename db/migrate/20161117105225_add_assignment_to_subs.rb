class AddAssignmentToSubs < ActiveRecord::Migration
  def change
    add_reference :subs, :assignments_week, index: true, foreign_key: true
    add_reference :subs, :assignment, index: true, foreign_key: true
  end
end

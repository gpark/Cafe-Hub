class AddAssignmentToOccurence < ActiveRecord::Migration
  def change
    add_reference :occurences, :assignment, index: true, foreign_key: true
  end
end

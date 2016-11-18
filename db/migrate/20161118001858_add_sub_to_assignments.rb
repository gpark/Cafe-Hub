class AddSubToAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :sub, index: true, foreign_key: true
  end
end

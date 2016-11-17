class AddAssignmentIdToSubs < ActiveRecord::Migration
  def change
    add_column :subs, :assignment_id, :integer
  end
end

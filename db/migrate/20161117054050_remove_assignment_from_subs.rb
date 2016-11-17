class RemoveAssignmentFromSubs < ActiveRecord::Migration
  def change
    remove_column :subs, :assignment, :integer
  end
end

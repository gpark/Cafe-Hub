class AddAssignmentToSubs < ActiveRecord::Migration
  def change
    add_column :subs, :assignment, :integer
  end
end

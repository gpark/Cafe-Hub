class RenameEntryOccurenceTableToOccurence < ActiveRecord::Migration
  def change
    rename_table :entry_occurences, :occurences
  end
end

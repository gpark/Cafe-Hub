class AddPreferenceEntryToEntryOccurences < ActiveRecord::Migration
  def change
    add_reference :entry_occurences, :preference_entry, index: true, foreign_key: true
  end
end
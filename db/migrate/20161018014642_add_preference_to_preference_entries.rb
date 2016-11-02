class AddPreferenceToPreferenceEntries < ActiveRecord::Migration
  def change
    add_reference :preference_entries, :preference, index: true, foreign_key: true
  end
end
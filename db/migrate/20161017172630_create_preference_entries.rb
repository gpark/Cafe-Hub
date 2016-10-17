class CreatePreferenceEntries < ActiveRecord::Migration
  def change
    create_table :preference_entries do |t|
      t.string :preference_type
      t.text :comments

      t.timestamps null: false
    end
  end
end

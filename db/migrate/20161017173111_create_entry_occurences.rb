class CreateEntryOccurences < ActiveRecord::Migration
  def change
    create_table :entry_occurences do |t|
      t.boolean :su
      t.boolean :m
      t.boolean :tu
      t.boolean :w
      t.boolean :th
      t.boolean :f
      t.boolean :sa
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end

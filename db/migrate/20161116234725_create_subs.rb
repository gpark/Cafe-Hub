class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.text :comments

      t.timestamps null: false
    end
  end
end

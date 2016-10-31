class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.integer :ppl_per_shift
      t.string :su_start
      t.string :su_end
      t.string :m_start
      t.string :m_end
      t.string :tu_start
      t.string :tu_end
      t.string :w_start
      t.string :w_end
      t.string :th_start
      t.string :th_end
      t.string :f_start
      t.string :f_end
      t.string :sa_start
      t.string :sa_end
      
      t.timestamps null: false
    end
  end
end

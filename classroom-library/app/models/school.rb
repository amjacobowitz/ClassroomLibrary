class School < ActiveRecord::Base
  def change
    create_table :schools do |t|


      t.timestamps null: false
    end
  end
end

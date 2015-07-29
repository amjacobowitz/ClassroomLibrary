class Quote < ActiveRecord::Base
  def change
    create_table :quotes do |t|


      t.timestamps null: false
    end
  end
end

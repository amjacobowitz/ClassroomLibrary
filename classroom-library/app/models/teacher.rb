class Teacher < ActiveRecord::Base
  def change
    create_table :teachers do |t|


      t.timestamps null: false
    end
  end
end

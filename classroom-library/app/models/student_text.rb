class StudentText < ActiveRecord::Base
  def change
    create_table :student_texts do |t|


      t.timestamps null: false
    end
  end
end

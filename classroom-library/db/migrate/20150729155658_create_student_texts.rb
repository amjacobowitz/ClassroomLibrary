class CreateStudentTexts < ActiveRecord::Migration
  def change
    create_table :student_texts do |t|

      t.timestamps
    end
  end
end

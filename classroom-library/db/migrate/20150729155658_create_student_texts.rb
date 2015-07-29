class CreateStudentTexts < ActiveRecord::Migration
  def change
    create_table :student_texts do |t|
      t.integer :student_id
      t.integer :text_id
      t.integer :rating, default: nil
      t.boolean :favorite, default: false
      t.boolean :checked_out, default: false
      t.boolean :completed, default: false
      t.boolean :abandoned, default: false
      t.string :reason_for_abandoning, default: ''
      t.string :review_title, default: ''
      t.string :review_content, default: ''

      t.timestamps
    end
  end
end

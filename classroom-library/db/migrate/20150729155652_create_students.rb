class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :handle
      t.integer :klass_number
      t.integer :lexile_level
      t.integer :klass_id

      t.timestamps
    end
  end
end

class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.integer :teacher_id
      t.integer :klass_number
      t.integer :school_year
      t.integer :grade

      t.timestamps
    end
  end
end

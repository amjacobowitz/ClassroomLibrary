class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :admin
      t.integer :school_id

      t.timestamps
    end
  end
end

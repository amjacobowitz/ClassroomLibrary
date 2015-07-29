class CreateFavoriteAuthors < ActiveRecord::Migration
  def change
    create_table :favorite_authors do |t|
      t.integer :student_id
      t.integer :author_id
      t.boolean :favorite, default: false

      t.timestamps
    end
  end
end

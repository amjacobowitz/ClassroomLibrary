class CreateFavoriteGenres < ActiveRecord::Migration
  def change
    create_table :favorite_genres do |t|
      t.integer :student_id
      t.integer :genre_id
      t.boolean :favorite, default: false

      t.timestamps
    end
  end
end

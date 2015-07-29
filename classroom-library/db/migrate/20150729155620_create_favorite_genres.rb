class CreateFavoriteGenres < ActiveRecord::Migration
  def change
    create_table :favorite_genres do |t|

      t.timestamps
    end
  end
end

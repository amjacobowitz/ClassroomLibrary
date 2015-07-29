class FavoriteGenre < ActiveRecord::Base
  def change
    create_table :favorite_genres do |t|


      t.timestamps null: false
    end
  end
end

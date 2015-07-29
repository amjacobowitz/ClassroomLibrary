class FavoriteAuthor < ActiveRecord::Base
  def change
    create_table :favorite_authors do |t|


      t.timestamps null: false
    end
  end
end

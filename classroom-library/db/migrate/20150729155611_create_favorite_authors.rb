class CreateFavoriteAuthors < ActiveRecord::Migration
  def change
    create_table :favorite_authors do |t|

      t.timestamps
    end
  end
end

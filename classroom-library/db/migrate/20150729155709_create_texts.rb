class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.integer :isbn
      t.integer :lexile_level
      t.integer :pages
      t.string :title
      t.string :author
      t.string :genre
      t.string :classroom

      t.timestamps
    end
  end
end

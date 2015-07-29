class Klass < ActiveRecord::Base
  def change
    create_table :klasses do |t|


      t.timestamps null: false
    end
  end
end

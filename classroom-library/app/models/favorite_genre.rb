class FavoriteGenre < ActiveRecord::Base
  validates :student_id, presence: true
  validates :genre_id, presence: true

  belongs_to :student
  belongs_to :genre
end

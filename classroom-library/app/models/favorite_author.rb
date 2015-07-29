class FavoriteAuthor < ActiveRecord::Base
  validates :student_id, presence: true
  validates :author_id, presence: true

  belongs_to :student
  belongs_to :author
end

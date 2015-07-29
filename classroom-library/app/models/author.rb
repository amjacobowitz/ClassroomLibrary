class Author < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :first_name, uniqueness: true
  validates :last_name, uniqueness: true

  has_many :favorite_authors
  has_many :students, through: :favorite_authors
end

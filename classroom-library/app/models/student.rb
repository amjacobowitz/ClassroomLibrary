class Student < ActiveRecord::Base
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :klass_id, presence: true

  before_save :to_lower

  belongs_to :klass

  has_many :favorite_genres
  has_many :genres, through: :favorite_genres

  has_many :favorite_authors
  has_many :authors, through: :favorite_authors

  has_many :student_texts
  has_many :texts, through: :student_texts


  def to_lower
    self.first_name = self.first_name.downcase
    self.last_name = self.last_name.downcase
  end

end

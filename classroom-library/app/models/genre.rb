class Genre < ActiveRecord::Base
  validates :category, presence: true

  validates :category, uniqueness: true

  before_save :to_lower

  has_many :favorite_genres
  has_many :students, through: :favorite_genres


  def to_lower
    self.category = self.category.downcase
  end

end

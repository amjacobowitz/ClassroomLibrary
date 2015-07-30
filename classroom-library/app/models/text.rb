class Text < ActiveRecord::Base
  validates :isbn, presence: true
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :pages, presence: true

  before_save :to_lower


  has_many :student_texts
  has_many :students, through: :student_texts


  def to_lower
    self.title = self.title.downcase
    self.author = self.author.downcase
    self.genre = self.genre.downcase
  end
end

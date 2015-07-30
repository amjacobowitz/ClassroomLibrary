class Klass < ActiveRecord::Base
  validates :teacher_id, presence: true
  validates :klass_number, presence: true
  validates :grade, presence: true

  validates :klass_number, uniqueness: true

  belongs_to :teacher

  has_many :students
end

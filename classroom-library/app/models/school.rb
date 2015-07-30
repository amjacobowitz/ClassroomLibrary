class School < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :teachers
  has_many :klasses, through: :teachers
end

class Teacher < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  validates :email, uniqueness: true


  before_save :to_lower

  belongs_to :school

  has_many :klasses
  has_many :students, through: :klasses
  has_many :groups

  has_secure_password

  def to_lower
    self.first_name = self.first_name.downcase
    self.last_name = self.last_name.downcase
    self.email = self.email.downcase
  end
end

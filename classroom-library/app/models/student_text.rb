class StudentText < ActiveRecord::Base
  validates :student_id, presence: true
  validates :text_id, presence: true

  belongs_to :text
  belongs_to :student
end

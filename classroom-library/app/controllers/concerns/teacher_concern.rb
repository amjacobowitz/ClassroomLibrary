module TeacherConcern
  extend ActiveSupport::Concern

  included do
    helper_method :assign_klass_id
  end

  def assign_klass_id(student)
    if student.klass_number == 601
      student.klass_id = 1
    elsif student.klass_number == 602
      student.klass_id = 2
    elsif student.klass_number == 603
      student.klass_id = 3
    elsif student.klass_number == 604
      student.klass_id = 4
    end
    student.save
  end
end

module StudentConcern
  extend ActiveSupport::Concern

  included do
    helper_method :total_pages_read
    helper_method :other_student_name_and_initial
    helper_method :all_student_transactions
    helper_method :current_student_name_and_initial
    helper_method :student_display_name
  end

  def total_pages_read(texts_to_search, transaction)
    @total_pages_read = 0
    texts_to_search.each do |completed_text|
      @total_pages_read += completed_text.pages
    end
    @total_pages_read
  end

 # could maybe go in view helpers
  def other_student_name_and_initial(student)
    @other_student_name_and_initial = student.first_name.capitalize + ' ' + student.last_name[0].capitalize
  end

  def all_student_transactions(student_id)
    @all_student_transactions = StudentText.where(student_id: student_id)
  end

  def current_student_name_and_initial
    @current_student_name_and_initial = current_student.first_name.capitalize + ' ' + current_student.last_name[0].capitalize
  end

  def student_display_name(student)
    @student_display_name = student.first_name.capitalize + ' ' + student.last_name[0].capitalize
  end
end

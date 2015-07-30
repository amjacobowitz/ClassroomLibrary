module TextConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_book_checked_out
    helper_method :current_owner_of_text
    helper_method :most_recent_transaction
    helper_method :favorite_or_unfavorite
  end

  def current_book_checked_out(student)
    current_transaction = StudentText.where(student_id: student.id).order(:id).last
    if current_transaction
      if current_transaction.checked_out == false
        return nil
      else
        @current_book_checked_out = Text.find_by(id: current_transaction.text_id)
      end
    end
  end

  def current_owner_of_text(text)
    current_transaction = StudentText.where(text_id: text.id).order(:id).last
    if current_transaction
      if current_transaction.checked_out == false
        return nil
      else
        @current_owner_of_text = Student.find_by(id: current_transaction.student_id)
      end
    end
  end

  def most_recent_transaction(student, text)
    @most_recent_transaction = StudentText.where(student_id: student.id).where(text_id: text.id).order(:id).last
  end

  def favorite_or_unfavorite_text(student, text)
    if most_recent_transaction(student, text)
      if most_recent_transaction(student, text).favorite == true
        @favorite_or_unfavorite_text = "favorite"
      else
        @favorite_or_unfavorite_text = "unfavorite"
      end
    else
      @favorite_or_unfavorite_text = "unfavorite"
    end
  end

end

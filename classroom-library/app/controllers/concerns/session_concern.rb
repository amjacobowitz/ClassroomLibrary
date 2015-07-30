module SessionConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_student
    helper_method :current_teacher
    helper_method :logged_in?
  end

  def student_login
    student = Student.find_by(handle: params[:handle])
    if student && student.password == params[:password]
      session[:student_id] = student.id
    else
      return nil
    end
  end

  def teacher_login
    teacher = Teacher.find_by(email: params[:email])
    if teacher && teacher.password == params[:password]
      session[:teacher_id] = teacher.id
    else
      return nil
    end
  end

  def logout
    session.clear
  end

  def current_teacher
    return nil if session[:teacher_id].blank?
    @current_teacher ||= session[:teacher_id] && Teacher.find(session[:teacher_id])
  end

  def current_student
    return nil if session[:student_id].blank?
    @current_student ||= session[:student_id] && Student.find(session[:student_id])
  end

# logged_in is mostly used to check if a student has permission to view the current page
  def logged_in?(current_page_id)
    if current_student.id == current_page_id
      return true
    else
      return false
    end
  end

end

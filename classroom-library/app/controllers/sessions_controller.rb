class SessionsController < ApplicationController
  def index
    render 'index', layout: false
  end

  def create_student
    if student_login
      redirect_to student_path(current_student)
    else
      redirect_to root_path
    end
  end

  def create_teacher
    if teacher_login
      redirect_to teacher_path(current_teacher)
    else
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end

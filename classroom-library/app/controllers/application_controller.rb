class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include SessionConcern
  include StudentConcern
  include GenreConcern
  include TeacherConcern
  include GroupConcern
  include TextConcern
  include QuoteConcern



  protect_from_forgery with: :exception
end

require 'csv'

class TextsController < ApplicationController
  def index
    @checked_out_texts = []
    @all_texts = Text.all
    checked_out_transactions = StudentText.where(checked_out: true)
    checked_out_transactions.each do |transaction|
      @checked_out_texts << Text.find(transaction.text_id)
    end
  end

  def show
    @text = Text.find_by(id: params[:id])
    @all_student_reviews_by_book = []
    @students_who_read_this_book = []
    transactions_with_this_book = StudentText.where(text_id: params[:id])
    if transactions_with_this_book
      average_ratings = []
      transactions_with_this_book.each do |transaction|
        if transaction.review_title != ''
          @all_student_reviews_by_book << transaction
        end

        @students_who_read_this_book << Student.find(transaction.student_id)
        if transaction.rating != nil
          average_ratings << transaction.rating
        end
        sum_of_ratings = 0
        average_ratings.each do |rating|
          sum_of_ratings += rating
        end
        if average_ratings.length > 0
          @average_rating_by_book = sum_of_ratings/average_ratings.length
        end
      end
    end
    render '/texts/show'
  end

  def new
    @text = Text.new
  end

  def edit
    @text = Text.find_by(id: params[:id])
  end

  def update
    text = Text.find_by(id: params[:id])
    text.update_attributes(isbn: params[:isbn], lexile_level: params[:lexile_level], pages: params[:pages], title: params[:title], author: params[:author], genre: params[:genre])
    text.save!
    redirect_to texts_path
  end

  def create
    text = Text.create(classroom: current_teacher.last_name, isbn: params[:isbn], lexile_level: params[:lexile_level], pages: params[:pages], title: params[:title], author: params[:author], genre: params[:genre])
    text.save
    redirect_to texts_path
  end

  def destroy
    text = Text.find_by(id: params[:id])
    text.destroy!
    redirect_to texts_path
  end

  def review_new
    @text = Text.find_by(id: params[:id])
    render 'review'
  end

  def review_update
    text = Text.find_by(id: params[:id])
    if most_recent_transaction(current_student, text)
      text_record = most_recent_transaction(current_student, text)
      text_record.review_title = params[:review_title]
      text_record.review_content = params[:review_content]
      p text_record
      text_record.save!
    else
      transaction = StudentText.create(student_id: current_student.id, text_id: params[:id], review_title: params[:review_title], review_content: params[:review_content])
      transaction.save!
    end
    redirect_to text_path(text)
  end

  def rate_new
    @text = Text.find_by(id: params[:id])
    render 'rate'
  end

  def rate_update
    text = Text.find_by(id: params[:id])
    if most_recent_transaction(current_student, text)
      text_record = most_recent_transaction(current_student, text)
      text_record.rating = params[:rating]
      text_record.save!
    else
      transaction = StudentText.create(student_id: current_student.id, text_id: params[:id], rating: params[:rating])
      transaction.save!
    end
    redirect_to text_path(text)
  end

  def favorite
    text = Text.find_by(id: params[:id])
    if most_recent_transaction(current_student, text)
      text_record = most_recent_transaction(current_student, text)
      text_record.favorite = true
      text_record.save!
    else
      text_record = StudentText.create(student_id: current_student.id, text_id: params[:id], favorite: true)
      text_record.save!
    end

    image_location = view_context.asset_url("favorite_icon.jpg")

    if request.xhr?
      render json: {image_location: image_location}
    else
      redirect_to text_path(text)
    end
  end

  def unfavorite
    text = Text.find_by(id: params[:id])
    text_record = most_recent_transaction(current_student, text)
    text_record.favorite = false

    text_record.save!

    image_location = view_context.asset_url('unfavorite_icon.jpg')


    if request.xhr?
      render json: {image_location: image_location}
    else
      redirect_to text_path(text)
    end
  end

  def checkin
    render 'checkin'
  end

  def checkin_update
    # Make sure to add jquery to check which radio button is selected and return here for favorite
    if params[:favorite] == 'yes'
      favorite_answer = true
    else
      favorite_answer = false
    end

    if params[:decision] == 'completed'
      text_completed = true
      text_abandoned = false
    else
      text_completed = false
      text_abandoned = true
    end

    text = Text.find_by(id: params[:id])
    most_recent_transaction(current_student, text).update_attributes(checked_out: false, text_id: params[:id], student_id: current_student.id, favorite: favorite_answer, rating: params[:rating], review_title: params[:review_title], review_content: params[:review_content], reason_for_abandoning: params[:reason_for_abandoning], completed: text_completed, abandoned: text_abandoned)

    most_recent_transaction(current_student, text).save!
    redirect_to student_path(current_student.id)
  end

  def student_checkout
    transaction = StudentText.create(student_id: current_student.id, text_id: params[:id], checked_out: true)
    transaction.save!
    redirect_to student_path(current_student.id)
  end

  def search
    @text = Text.where("author LIKE (?) OR title LIKE (?) OR genre LIKE (?)", "%#{params[:search_keyword]}%", "%#{params[:search_keyword]}%", "%#{params[:search_keyword]}%").last
    render 'texts/text_search_result', layout: false
  end
end


# Code to upload is below, but it is copied from students and needs to be rewritten with the informtion for texts

# get '/upload_texts' do
#  erb :'texts/upload_texts'
# end

# post '/upload_texts' do
#   file_data = params[:my_file][:tempfile].read
#   CSV.parse(file_data, headers: true, header_converters: :symbol) do |row|
#     text = Text.create(author: row[:author], last_name: row[:last_name], password: row[:password], handle: row[:handle], klass_number: row[:texts_number], lexile_level: row[:lexile_level])
#     text.save
#   end
#   redirect "/texts/#{current_teacher.id}"
# end

# post '/texts/:id/teacher_checkout' do
#   student = Student.find_by(handle: params[:handle])
#   StudentText.create(student_id: student.id, text_id: params[:id])
#   text = Text.find_by(id: params[:id])
#   text.checked_out = true
#   text.save!
#   redirect "/students/#{current_teacher.id}"
# end


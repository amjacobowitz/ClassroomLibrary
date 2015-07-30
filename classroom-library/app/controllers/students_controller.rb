class StudentsController < ApplicationController

  def show
    @student = Student.find(params[:id])
    @genres = Genre.all
    @favorite_authors = []
    favorite_author_transactions = FavoriteAuthor.where(student_id: @student.id)
    if favorite_author_transactions
      favorite_author_transactions.each do |favorite_author_transaction|
        @favorite_authors << Author.find(favorite_author_transaction.author_id)
      end
    end

    @current_transaction = StudentText.where(student_id: @student.id).order(:id).last
    @transactions = all_student_transactions(@student.id)
    if @current_transaction
      @current_book = Text.find_by(id: @current_transaction.text_id)
    else
      @current_book = nil
    end

    @favorite_texts = []
    @completed_texts = []
    @abandoned_texts = []
    transactions = StudentText.where(student_id: @student.id)
    transactions.each do |transaction|
      if transaction.favorite == true
        @favorite_texts << Text.find(transaction.text_id)
      end
      if transaction.completed == true
        @completed_texts << Text.find(transaction.text_id)
        @total_pages_read = total_pages_read(@completed_texts, transaction)
      end
      if transaction.abandoned == true
        @abandoned_texts << Text.find(transaction.text_id)
      end
    end
    render 'students/show'
  end

  def index
  end

  def new
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end

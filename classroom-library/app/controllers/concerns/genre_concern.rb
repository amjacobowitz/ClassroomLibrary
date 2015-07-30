module GenreConcern
  extend ActiveSupport::Concern

  included do
    helper_method :favorite_or_unfavorite_genre
    helper_method :favorite_genre_transaction
  end

  def favorite_genre_transaction(student, genre)
    @favorite_genre_transaction = FavoriteGenre.where(genre_id: genre.id).where(student_id: current_student.id).order(:id).last
  end

  def favorite_or_unfavorite_genre(student, genre)
    if favorite_genre_transaction(student, genre)
      if favorite_genre_transaction(student, genre).favorite == true
        @favorite_or_unfavorite_genre = "favorite"
      else
        @favorite_or_unfavorite_genre = "unfavorite"
      end
    else
      @favorite_or_unfavorite_genre = "unfavorite"
    end
  end
end

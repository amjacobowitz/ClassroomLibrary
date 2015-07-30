class GenresController < ApplicationController
  def favorite
    genre = Genre.find(params[:id])
    if favorite_genre_transaction(current_student, genre)
      genre_record = favorite_genre_transaction(current_student, genre)
      genre_record.favorite = true
      genre_record.save!
    else
      transaction = FavoriteGenre.create(student_id: current_student.id, genre_id: params[:id], favorite: true)
      transaction.save!
    end

    image_location = view_context.asset_url('favorite_icon.jpg')
    genre_id = params[:id]
    p '*' * 50
    p params
    p '*' * 50

    if request.xhr?
      render json: {image_location: image_location, genre_id: genre_id}
    else
      redirect_to student_path(current_student.id)
    end
  end

  def unfavorite
    genre = Genre.find(params[:id])
    genre_record = favorite_genre_transaction(current_student, genre)
    genre_record.favorite = false
    genre_record.save!

    image_location = view_context.asset_url('unfavorite_icon.jpg')
    genre_id = params[:id]

    if request.xhr?
      render json: {image_location: image_location, genre_id: genre_id}
    else
      redirect_to student_path(current_student.id)
    end
  end
end

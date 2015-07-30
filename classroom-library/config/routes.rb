Rails.application.routes.draw do
  root 'sessions#index'
  post '/login_student', to: 'sessions#create_student'
  post '/login_teacher', to: 'sessions#create_teacher'
  delete '/logout', to: 'sessions#destroy'

  get '/genres/:id/favorite', to: 'genres#favorite', as: 'genre_favorite'
  get '/genres/:id/unfavorite', to: 'genres#unfavorite', as: 'genre_unfavorite'

  resources :students

end

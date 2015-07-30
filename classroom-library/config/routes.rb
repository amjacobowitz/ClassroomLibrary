Rails.application.routes.draw do
  root 'sessions#index'
  post '/login_student', to: 'sessions#create_student'
  post '/login_teacher', to: 'sessions#create_teacher'
  delete '/logout', to: 'sessions#destroy'

  get '/genres/:id/favorite', to: 'genres#favorite', as: 'genre_favorite'
  get '/genres/:id/unfavorite', to: 'genres#unfavorite', as: 'genre_unfavorite'

  resources :students
  resources :texts
  get '/texts/search', to: 'texts#search', as: 'text_search'
  get '/texts/:id/student_checkout', to: 'texts#student_checkout', as: 'student_checkout'
  get '/texts/:id/teacher_checkout', to: 'texts#teacher_checkout', as: 'teacher_checkout'
  get '/texts/:id/checkin', to: 'texts#checkin', as: 'checkin'
  put '/texts/:id/checkin', to: 'texts#checkin_update'
  get '/texts/:id/review', to: 'texts#review_new', as: 'review'
  put '/texts/:id/review', to: 'texts#review_update'
  get '/texts/:id/rate', to: 'texts#rate_new', as: 'rate'
  put '/texts/:id/rate', to: 'texts#rate_update'
  get '/texts/:id/favorite', to: 'texts#favorite', as: 'text_favorite'
  get '/texts/:id/unfavorite', to: 'texts#unfavorite', as: 'text_unfavorite'
end

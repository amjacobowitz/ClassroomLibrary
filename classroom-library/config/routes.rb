Rails.application.routes.draw do
  get 'texts/index'

  get 'texts/show'

  get 'texts/new'

  get 'texts/edit'

  get 'texts/update'

  get 'texts/create'

  get 'texts/destroy'

  get 'teachers/index'

  get 'teachers/show'

  get 'teachers/new'

  get 'teachers/edit'

  get 'teachers/update'

  get 'teachers/create'

  get 'teachers/destroy'

  get 'sessions/index'

  get 'sessions/show'

  get 'sessions/new'

  get 'sessions/edit'

  get 'sessions/update'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'groups/index'

  get 'groups/show'

  get 'groups/new'

  get 'groups/edit'

  get 'groups/update'

  get 'groups/create'

  get 'groups/destroy'

  get 'genre/index'

  get 'genre/show'

  get 'genre/new'

  get 'genre/edit'

  get 'genre/update'

  get 'genre/create'

  get 'genre/destroy'

  get 'author/index'

  get 'author/show'

  get 'author/new'

  get 'author/edit'

  get 'author/update'

  get 'author/create'

  get 'author/destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

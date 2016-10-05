Rails.application.routes.draw do
   devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
   match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'static_pages#index'
   authenticated :user do
  root :to => 'static_pages#index', as: :authenticated_root
end
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  post 'static_pages/get_hotel_list' => 'static_pages#get_hotel_list', :as => "get_hotel_list"
  post 'static_pages/go_search_flights' => 'static_pages#go_search_flights', :as => "go_search_flights"
  post 'static_pages/get_list_bus' => 'static_pages#get_list_bus', :as => "get_list_bus"
  get 'static_pages/contact' => 'static_pages#contact', :as => "get_contact"
  get 'static_pages/get_place_search' => 'static_pages#get_place_search', :as => "get_place_search"
  get 'static_pages/get_destination' => 'static_pages#get_destination', :as => "get_destination"
  get 'static_pages/get_detail_tour' => 'static_pages#get_detail_tour', :as => "get_detail_tour"
  get 'static_pages/get_booking_tour' => 'static_pages#get_booking_tour', :as => "get_booking_tour"
  post 'static_pages/send_otp' => 'static_pages#send_otp', :as => "send_otp"
  post 'static_pages/confirm_booking' => 'static_pages#confirm_booking', :as => "confirm_booking"
  get 'static_pages/upload_document' => 'static_pages#upload_document', :as => "upload_document"
  post 'static_pages/upload_doc' => 'static_pages#upload_doc', :as => "upload_doc"
  post 'static_pages/go_let_me_plan' => 'static_pages#go_let_me_plan', as: :go_let_me_plan
  get 'static_pages/get_review_path' => 'static_pages#get_review_path', as: :get_review
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

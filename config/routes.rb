Taxi::Application.routes.draw do

  resources :inform_mails do
    get :change_text, on: :collection
    get :do_change_text, on: :collection
  end

  resources :activities
  resources :bonus_programs

  get "admin/index"
  root "pages#index"

  scope "api" do
    resources :users do
      resources :trips
    end
    resources :clients do
      get :autocomplete_natural_person_name, on: :collection
      get :check, on: :collection
      post :windraw_bonus_points, on: :member
      get :set_check, on: :collection
      collection {
        get :bonus_points
        get :search
      }
    end
    resources :operators
    resources :trips do
      get :autocomplete_client_email, :on => :collection
    end
  end
    devise_for :users, skip: :registrations#, :controllers => { :registrations => "auth/registrations" }
    devise_for :clients, skip: :sessions#, :controllers => { :registrations => "auth/registrations" }
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

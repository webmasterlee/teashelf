Rails.application.routes.draw do
  
  namespace :admin do
    resources :users, :teas
  end

  post 'exclusions/create'
  get 'info/index'
  get 'teas/random'
  get 'teas/get_tea_names'
  get 'teas/get_vendors'
  post 'account/found_username'
  post 'wishlists/save_suggestion'
  root 'info#index'
  
  get 'legal', to: 'info#legal'

  get 'about', to: 'info#about'
  get 'contact', to: 'info#contact', as: 'contact'
  post 'contact', to: 'info#contact_send'
  get 'thanks', to: 'teas#index'
  
  #get '/about' => 'pages#about'

  resources :notes

  resources :atts
  
  resources :teas

  resources :wishlists

  resources :tea_types

  resources :preferences

  devise_for :users,
            :controllers => { :registrations => "my_devise/registrations", :sessions => "my_devise/sessions"}

  

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

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get '/dashboard' => 'dashboard#index'

  root 'dashboard#index'

	namespace :admin do

		resources :categories, only: [:index, :show]
		resources :products
    resources :orders, only: [:index]
    resources :addresses
		resources :users do 
      resources :addresses
      resources :orders
    end
	end

end

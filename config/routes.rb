Rails.application.routes.draw do
  namespace :admin do
    get 'categories/index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get '/dashboard' => 'dashboard#index'

	namespace :admin do 
		resources :categories, only: [:index]
	end

end

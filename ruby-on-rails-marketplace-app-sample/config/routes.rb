Market::Application.routes.draw do

	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

	devise_for :users, path: "", :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup'}, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations', :passwords => 'users/passwords', :confirmations => 'users/confirmations'} do
		get 'logout', to: 'devise/sessions#destroy', :as => :destroy_user_session
	end

	# Angularjs Templates
	match 'templates/(*path)', to: 'assets#templates', via: :get

	# ----------------------------------------------------
	# Account
	# ----------------------------------------------------

	namespace :account do
		root to: redirect('/account/profile/edit')

		resource :profile, only: [:edit, :update]
		get :profile, to: redirect('/account/profile/edit')

		resource :directory, only: [:edit, :update]
		get :directory, to: redirect('/account/directory/edit')

		resource :billing, only: [:edit, :update]
		get :billing, to: redirect('/account/billing/edit')

		resources :saved_searches, only: [:index, :destroy, :create], path: 'saved-searches'
		resources :favorites, only: [:index, :destroy, :create]
		resources :posts, only: [:index, :destroy, :create, :new]

		resources :listings do
			collection do
				get :renew
			end

			member do
				get :renew
				get :contact
			end
		end
	end

	resource :search
	resources :categories, :photos
	# resources
	resources :business_tags, only: [:show], path: 'category'
	resources :listings, :directory, only: [:show] do
		member do
			post :contact
		end
	end

	resources :listing_drafts, only: [:create]
	resources :support_tickets, only: [:create]
	resources :posts, only: [:show, :index]

	# ----------------------------------------------------
	# Static Pages
	# ----------------------------------------------------

	root to: 'pages#show', id: 'home'
	# root to: redirect('/search'), id: 'home'
	get 'privacy' => 'high_voltage/pages#show', id: 'privacy'
	get 'terms' => 'high_voltage/pages#show', id: 'terms'
	get 'about' => 'high_voltage/pages#show', id: 'about'
	get 'sell' => 'high_voltage/pages#show', id: 'sell'

	# ----------------------------------------------------
	# Route Catchall
	# ----------------------------------------------------

	get '(*slug)' => 'searches#query'
end

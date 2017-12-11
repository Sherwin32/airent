Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'

	# get '/users/new', to: 'users#new', as: 'new_user'
	post '/user', to: 'users#create', as: 'sign_up'
	get 'users/:id', to: 'users#show', as: 'user'

	# get '/login', to: 'sessions#new', as: 'login'
	post '/login', to: 'sessions#create', as: 'login'
	delete '/logout', to: 'sessions#destroy'
	get '/about', to: 'sessions#index', as: 'about'

	post '/group/create', to: 'groups#create', as: 'create_group'
	post '/group/join', to: 'groups#join', as: 'join_group'
	get '/group/:group_id', to: 'groups#show', as: 'group'
	delete '/group/destroy/:group_id', to: 'groups#destroy', as: 'destroy_group'

	post '/item/create', to: 'items#create', as: 'create_item'
	get '/item/:item_id', to: 'items#show', as: 'item'
	put '/item/like/:item_id', to: 'items#like', as: 'like'
	put '/item/unlike/:item_id', to: 'items#unlike', as: 'unlike'

end

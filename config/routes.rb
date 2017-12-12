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
	put '/group/:group_id/add_manager/:user_id', to: 'groups#add_manager', as: 'add_manager'
	put '/group/:group_id/remove_manager/:user_id', to: 'groups#remove_manager', as: 'remove_manager'
	put '/group/:group_id/kick_out/:user_id', to: 'groups#kick_out', as: 'kick_out'
	put '/group/:group_id/change_passcode', to: 'groups#change_passcode', as: 'change_passcode'

	post '/item/create', to: 'items#create', as: 'create_item'
	get '/item/:item_id', to: 'items#show', as: 'item'
	put '/item/like/:item_id', to: 'items#like', as: 'like'
	put '/item/unlike/:item_id', to: 'items#unlike', as: 'unlike'
	put '/item/subscribe/:item_id', to: 'items#subscribe', as: 'subscribe'
	put '/item/unsubscribe/:item_id', to: 'items#unsubscribe', as: 'unsubscribe'
	put '/item/:item_id/force_unsubscribe/:tenant_id', to: 'items#force_unsubscribe', as: 'force_unsubscribe'
	put '/item/:item_id/confirm_rental/:tenant_id', to: 'items#confirm_rental', as: 'confirm_rental'
	put '/item/:item_id/confirm_return/:tenant_id', to: 'items#confirm_return', as: 'confirm_return'

end

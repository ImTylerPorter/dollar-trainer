Rails.application.routes.draw do

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	resources :conversations do
		resources :answers
	end


	authenticated :user do 
  	root 'conversations#index', as: "authenticated_root"
  end

	root 'welcome#index'

end

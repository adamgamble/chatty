Chatty::Application.routes.draw do
  devise_for :users
  root :to => "rooms#index"

  resources :rooms, :only => [:index, :show]
end

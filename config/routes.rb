Chatty::Application.routes.draw do
  root :to => "rooms#index"

  resources :rooms, :only => [:index, :show]
end

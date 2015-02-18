Rails.application.routes.draw do
  resources :links, only: [:new, :create, :show]
end

Rails.application.routes.draw do
  resources :links, only: [:show, :index, :new, :create]
  resources :analytics, only: [:show]

  root to: "links#new"
  get "/:short_url" => "links#redirect"
end

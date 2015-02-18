Rails.application.routes.draw do
  resources :links, only: [:new, :create, :show]

  root to: "links#new"
  get "/:short_url" => "links#redirect"
end

Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get "/signout" => "sessions#destroy", as: :signout
  get '/api_request' => 'home#api_request', as: :api_request
  root to: 'home#index'
end

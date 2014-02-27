Rails.application.routes.draw do
  get '/api_request' => 'home#api_request', as: :api_request
  root to: 'home#index'
end

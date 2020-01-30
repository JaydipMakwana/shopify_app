Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  get '/customers', to: 'home#customers'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

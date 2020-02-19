Rails.application.routes.draw do
  root :to => 'home#index'
  get 'product_listing', to: 'home#product_listing'
  mount ShopifyApp::Engine, at: '/'
  # post 'customers/import', to: 'home#import_customers', as: :import_customers
  resources :customers, only: %i[index] do
    collection do
      post 'import'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

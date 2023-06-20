Rails.application.routes.draw do
  # Convert the routes to use scope "payment"
  scope 'payment' do
    get '/', to: 'payment#index', as: 'access_page'
    get 'webhook', to: 'payment#webhook', as: 'access_webhook'
    get 'create', to: 'payment#create', as: 'buy_access'
    get 'cancel', to: 'payment#cancel', as: 'buy_access_cancel'
  end



  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'staticpage#index'
end

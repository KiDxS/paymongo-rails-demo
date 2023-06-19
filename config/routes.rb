Rails.application.routes.draw do
  # Convert the routes to use scope "payment"
  scope 'payment' do
    get '/', to: 'payment#index', as: 'access_page'
    get 'create', to: 'payment#create', as: 'buy_access'
    get 'success', to: 'payment#success', as: 'buy_access_success'
    get 'cancel', to: 'payment#cancel', as: 'buy_access_cancel'
  end



  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

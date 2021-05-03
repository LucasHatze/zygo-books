Rails.application.routes.draw do
  resources :books do
    collection do
      get :search
    end
  end


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  root to: 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

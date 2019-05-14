Rails.application.routes.draw do
  resources :categories
  resources :ingredients
  resources :restaurants do
    collection do
      get 'homepage'
      post 'homepage'
    end
  end
  resources :dishes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'restaurants#homepage'

end

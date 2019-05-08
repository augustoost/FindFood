Rails.application.routes.draw do
  resources :categories
  resources :ingredients
  resources :restaurants
  resources :dishes do
    collection do
      get 'homepage'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'dishes#homepage'

end

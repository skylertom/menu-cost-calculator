Rails.application.routes.draw do
  namespace :admin do
      resources :ingredients
      resources :inventory_items
      resources :recipes
      resources :recipe_items

      root to: "ingredients#index"
    end
    root to: "pages#home"
end

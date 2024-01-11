Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "logs#index"
  post "logs/search", to: "logs#search"
  get "search_analytics", to: "search_analytics#index"
end

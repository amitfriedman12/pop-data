Rails.application.routes.draw do
  resources :zips, only: [:show]
end

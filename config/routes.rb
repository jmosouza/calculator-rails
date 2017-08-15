Rails.application.routes.draw do
  resources :calculations, only: :create
end

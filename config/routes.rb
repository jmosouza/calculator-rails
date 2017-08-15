Rails.application.routes.draw do
  resources :calculations, only: :create
  get '/', to: 'calculator#index'
end

Rails.application.routes.draw do
  root to: 'categories#index'
  resources :categories do
    resources :trainings, only:[:index, :create, :edit, :update, :destroy]
  end
end

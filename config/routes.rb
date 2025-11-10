Rails.application.routes.draw do
  root 'home#index'

  post 'savings/compare'
  get 'savings/result'
end

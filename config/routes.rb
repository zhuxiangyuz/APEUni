Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :word_books
        resources :words do
          patch "mastered", on: :collection
        end
      end
    end
  end
end

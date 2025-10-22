Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "hello", to: "greetings#show"

      resources :teachers
      resources :students do
        resources :enrollments, only: :index
      end

      resources :courses do
        resources :assignments, only: :index
        resources :enrollments, only: :index
      end

      resources :assignments
      resources :enrollments, only: %i[index create destroy]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "api/v1/greetings#show"
end

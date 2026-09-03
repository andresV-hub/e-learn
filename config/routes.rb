Rails.application.routes.draw do
  
  resources :enrollments do
    get :my_students, on: :collection
    member do
        get :certificate
      end
  end
  #devise_for :users
  devise_for :users, :controllers => { registrations: 'users/registrations', 
                                       omniauth_callbacks: 'users/omniauth_callbacks'}
  
  resources :youtube, only: :show
  resources :tags, only: [:create, :index, :destroy]
  resources :courses, except: [:edit] do
    # Rails 8.1 ya no admite varios nombres de ruta en una sola llamada a `get`
    # (ArgumentError: Wrong number of arguments), así que se declaran una a una.
    collection do
      get :purchased
      get :pending_review
      get :created
      get :unapproved
    end
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons do
      resources :comments, except: [:index]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create] do
    end
    resources :course_wizard, controller: 'courses/course_wizard'
  end
  
  
  resources :users, only: [:index, :edit, :show, :update]
  root 'static_pages#landing_page'
  
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'activity', to: 'static_pages#activity'
  get 'analytics', to: 'static_pages#analytics'
  #get 'charts/users_per_day', to: 'charts#users_per_day'
  #get 'charts/enrollments_per_day', to: 'charts#enrollments_per_day'
  #get 'charts/course_popularity', to: 'charts#course_popularity'
  
  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end
  # Comprobación de estado que Rails genera desde 7.1. Devuelve 200 si la
  # aplicación arrancó, y 500 si algún initializer falló. La usan el healthcheck
  # del contenedor y los balanceadores; production.rb la silencia en el log.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

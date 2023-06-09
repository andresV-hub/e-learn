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
    get :purchased, :pending_review, :created, :unapproved, on: :collection
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

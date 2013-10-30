NotifyIO::Application.routes.draw do
  get "notifications/new"

  get "notifications/create"

  get "notifications/show"

  get "notifications/index"

  devise_for :users
  resources :users, only: [:show]

  resources :organizations do
    resources :notifications
  end

  #resources :subscriptions

  root to: "pages#splash_mock"

  get "/organizations/:id/add_user/:user_email", to: "organizations#add_user"
#  get "/subscriptions/new", to: "subscriptions#add_user"
  #get "/subscriptions/add_user/:user_id/:organization_id", to: "subscriptions#add_user"
  post "/subscriptions/add_user", to: "subscriptions#add_user", as: 'add_user_to_organization'

  # Static pages
  pages :splash_mock, :api_doc_mock, :login_mock, :signup_mock, :dashboard_mock, :settings_mock, :user_mock, :create_organization_mock

end

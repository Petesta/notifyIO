NotifyIO::Application.routes.draw do
  devise_for :users

  # get "users/new"

  # get "users/index"

  # get "users/create"

  # get "users/show"

  # get "users/edit"

  # get "users/update"

  # get "users/destroy"

  root to: "pages#splash_mock"

  # Static pages
  pages :splash_mock, :api_doc_mock, :login_mock, :signup_mock, :dashboard_mock, :settings_mock, :user_mock, :create_organization_mock

end

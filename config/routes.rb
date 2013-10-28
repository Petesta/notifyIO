NotifyIO::Application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :organizations

  root to: "pages#splash_mock"

  get "/organizations/:id/add_user/:user_email", to: "organizations#add_user"

  # Static pages
  pages :splash_mock, :api_doc_mock, :login_mock, :signup_mock, :dashboard_mock, :settings_mock, :user_mock, :create_organization_mock

end

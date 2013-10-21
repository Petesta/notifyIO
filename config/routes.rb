NotifyIO::Application.routes.draw do
  root to: "pages#splash_mock"

  # Static pages
  pages :splash_mock, :api_doc_mock, :login_mock, :signup_mock, :dashboard_mock, :settings_mock, :user_mock, :create_organization_mock

end

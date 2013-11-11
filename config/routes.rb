NotifyIO::Application.routes.draw do
  get "notifications/new"

  get "notifications/create"

  get "notifications/show"

  get "notifications/index"
  
  #get "organizations/notifications/paginate/:id/:page_number", to: "organizations#return_html"
  get "organizations/notifications/paginate/:id/", to: "organizations#return_html"
  
  devise_for :users
  
  resources :users, only: [:show]

  resources :organizations do
    resources :notifications, only: [:show, :index] do
      # link_to filter_organization_notifications_path(@organization.id)
      collection do
        get 'filter' => 'organizations#return_notification_type', as: 'filter'
      end

      member do
      end
    end
  end

  resources :notifications, only: [:create]

  root to: "application#index"

  get "/organizations/:id/add_user/:user_email", to: "organizations#add_user"
#  get "/subscriptions/new", to: "subscriptions#add_user"
  #get "/subscriptions/add_user/:user_id/:organization_id", to: "subscriptions#add_user"
  post "/subscriptions/add_user", to: "subscriptions#add_user", as: 'add_user_to_organization'

  # Static pages

end

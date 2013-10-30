class NotificationsController < ApplicationController
  before_filter :api_auth, only: [:create]
  def new
  end

  def create # Used by api
    n = @organization.notifications.build(notification_type: params[:notification_type], message: params[:message])
    if n.save
      render json: n
    else
      render text: 'fuck'
      # return error message to api client
    end
  end

  def show
  end

  def index
    @notifications = Notification.where(organization_id: params[:organization_id])
  end

  private
  def api_auth
    @organization = Organization.find_by_api_key(params[:api_key])
    unless @organization
      head :unauthorized
    end
  end
end

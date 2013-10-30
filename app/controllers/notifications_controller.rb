class NotificationsController < ApplicationController
  before_filter :api_auth, only: [:create]
  def new
  end

  def create

  end

  def show
  end

  def index
    @notifications = Notification.where(organization_id: params[:organization_id])
  end

  private
  def api_auth
    unless params[:auth_token] == 'abc'
      head :unauthorized
    end
  end
end

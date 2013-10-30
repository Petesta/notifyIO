class NotificationsController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def index
    @notifications = Notification.where(organization_id: params[:organization_id])
  end
end

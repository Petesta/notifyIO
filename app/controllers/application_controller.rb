class ApplicationController < ActionController::Base
  protect_from_forgery
 
 def index
#   @resource = User.new
#   binding.pry
 end
end

module ApplicationHelper
 def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end

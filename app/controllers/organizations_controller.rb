class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_has_access?

  def new
    @organization = Organization.new
  end

  def index
    @organizations = Orgnization.all
  end

  def create
    @organization = Organization.new(params[:organization])
    @organization.users << current_user

    if @organization.save
      flash[:notice] = "Successful"
      redirect_to organization_path(@organization)
    else
      flash.now[:alert] = "Something went wrong!"
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    Organization.find(params[:id]).destroy
    redirect_to root
  end

  private

  def user_has_access?
    @organization = Organization.find(params[:id])

    unless @organization.users.include?(current_user)
      flash[:error] = "You don't have access!"
      redirect_to root_path
    end
  end
end

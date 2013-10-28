class OrganizationsController < ApplicationController
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
      # TODO change to success & make flash work
      flash[:notice] = "Successful"
      redirect_to organization_path(@organization)
    else
      flash.now[:error] = "Something went wrong!"
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
end

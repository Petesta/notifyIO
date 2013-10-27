class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def index
    @organizations = Orgnization.all
  end

  def create
    @organization = Organization.new(params[:id])
    
    if @organization.save
      flash[:success] = "Successful"
    else
      flash.now[:error] = "Something went wrong!"
      render :new
    end
  end

  def show
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

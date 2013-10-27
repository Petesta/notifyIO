class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.new(params[:id])

    if @user.save
      flash[:success] = "Successful"
      # redirect_to
    else
      flash.now[:error] = "Something went wrong!"
      render :new
    end

  end

  def destroy
    User.find(params[:id]).destroy
    #redirct_to
  end

end

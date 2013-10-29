class UsersController < ApplicationController
  before_filter :is_correct_user?, only: [:show, :edit, :update, :destory]

  def index
    @users = User.all
  end

  def show
    @user = current_user

    respond_to do |format|
      format.html
      format.json { render json: @user.organizations }
    end
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

  private

  def is_correct_user?
    unless params[:id].to_i == current_user.id
      flash[:alert] = "You don't have access!"
      redirect_to root_path
    end
  end

end

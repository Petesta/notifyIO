class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_has_access?

  def new
    @subscription = Subscription.new
  end

  def index
    @subscription = Subscription.all
  end

  def create
    @subscription = Subscription.new(params[:subscription])

    if @subscription.save
      flash[:notice] = "Successful"
      redirect_to organization_path(current_user)
    else
      flash.now[:alert] = "Something went wrong!"
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    Subscription.find(params[:id]).destroy
    redirect_to root
  end

  def add_user
    # hack.  change this to us user id
    # you cant send a dot in the url without weird shit happening
    # in this case it marks it as "format" in the params dict.
    # ... so we'll use that
#    dot_com = params[:format].to_s
#    email = params[:user_email].to_s + "." + dot_com

#    binding.pry
    user_id = params[:user_id]
    org_id = params[:organization_id]
    user = User.find(user_id) if User.exists?(user_id)
    org = Organization.find(org_id) if Organization.exists?(org_id)


    if user.nil?
      binding.pry
      flash[:alert] = 'That user does not exist!'
    elsif org.nil?
      flash[:alert] = 'That organization does not exist!'
      redirect_to user_path(current_user)
      return #o/w we redirect to org path later
    elsif org.users.include?(user)
      flash[:alert] = 'That user is already in this organization'
    else
      org.users << user
      flash[:notice] = "User #{user.email} added!"
    end
    redirect_to organization_path(org)

  end

  private

  def user_has_access?
    @subscription = Subscription.find(params[:id]) if params[:id]
    return if @subscription.nil?
   
    if !@subscription.user.id != current_user.id
      flash[:error] = "You don't have access!"
      redirect_to root_path
    end
  end
end

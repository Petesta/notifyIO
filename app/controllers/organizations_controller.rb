class OrganizationsController < ApplicationController
  # before_filter :authenticate_user!
  # before_filter :user_has_access?, :except => [:new, :show]

  PAGE_SIZE = 5

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
      flash[:success] = "Successful"
      redirect_to organization_path(@organization)
    else
      flash.now[:alert] = "Something went wrong!"
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
    @notifications = @organization.notifications_for_page(1)
    #@notifications = @organization.notifications.paginate(:page => params[:page], :per_page => 5).order('id DESC')
  end

  def edit
  end

  def update
  end

  def destroy
    Organization.find(params[:id]).destroy
    redirect_to root
  end

  def add_user
    # hack.  change this to us user id
    # you cant send a dot in the url without weird shit happening
    # in this case it marks it as "format" in the params dict.
    # ... so we'll use that
    dot_com = params[:format].to_s
    email = params[:user_email].to_s + "." + dot_com

    new_user = User.find_by_email(email)

    if new_user.nil?
      binding.pry
      flash[:alert] = 'That user does not exist!'
    elsif @organization.users.include?(new_user)
      flash[:notice] = 'That user is already in this organization'
    else
      @organization.users << new_user
      flash[:success] = "User #{new_user.email} added!"
    end

    redirect_to organization_path(@organization)
  end

  def return_html
    @organization = Organization.find(params[:id])
    page_number = params[:page_number].to_i
    num_notifications = @organization.notifications.count

    respond_to do |format|
        format.html do
          val = num_notifications - PAGE_SIZE * (page_number - 1)
          #puts val

          if PAGE_SIZE * page_number <= @organization.notifications.count
            #render partial: "notifications/notification", collection: @organization.notifiations_for_page(page_number)
            render partial: "notifications/notification", collection: @organization.notifications.slice((page_number - 1) * 5, 5)
          elsif num_notifications - PAGE_SIZE * (page_number - 1) > 0
            offset = num_notifications - PAGE_SIZE * (page_number - 1)
            render partial: "notifications/notification", collection: @organization.notifications.slice((page_number - 1) * 5, page_number * 5 - (5 - offset))
          else
            #puts "past end, rendering nothing"
            render json: { flag: true }
          end
        end
      end
  end

  def return_notification_type
    @organization = Organization.find(params[:organization_id])
    not_type = params[:notification_type].to_s
    #puts params
    #puts @organization.filter_notifications(not_type)
    @notifications = @organization.filter_notifications(not_type)
  end

  private

  def user_has_access?
    @organization = Organization.find(params[:id]) if params[:id]
    return if @organization.nil?

    if !@organization.users.include?(current_user)
      flash[:error] = "You don't have access!"
      redirect_to root_path
    end
  end

end

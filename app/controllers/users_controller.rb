class UsersController < ApplicationController
#  before_filter :signed_in_user, only: [:edit, :update]
 # before_filter :correct_user,   only: [:edit, :update]
  #before_filter :admin_user,     only: :destroy
  def new
  	@user = User.new
  end
  def show

    if signed_in?
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end
  def create
    @user = User.new(params[:user])

    if @user.save
      domain_now = @user.email.split('@').last
      if Domain.all.empty?

      	d_first = Domain.new(name: domain_now)
      	d_first.users<<(@user)
      	d_first.save
      	
      else
      	d_flag = 0
      	Domain.all.each do |d|
    		if d.name == domain_now
    			d.users<<(@user)
    			d_flag = 1
    		end
    	end
    	if d_flag == 0
    		d_new = Domain.new(name: domain_now)
    		d_new.users<<(@user)
    		d_new.save
    		
    	end
      end
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      sign_in @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @user_roles = @user.types
    @all_roles = @user.domain.types.all
  end
  def updaterole
    @roles = params[:roles_names]
    @user = User.find(params[:id])
    @roles.each do |r|
      if not @user.types.find_by_name(r)
        @user.types<<(@user.domain.types.find_by_name(r))
      end
    redirect_to @user
    end


  end
  def index
    @users = User.paginate(page: params[:page]) 
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end

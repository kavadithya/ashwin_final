class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:updaterole, :destroy]
  
  def new
  	@user = User.new
  end
  def show

    if signed_in?
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
    @count_elements = 0
    @user.types.each do |t|
      @count_elements += t.elements.size
    end

  end
  def create
    @user = User.new(params[:user])
    
    if @user.save
      domain_now = @user.email.split('@').last
      if Domain.all.empty?

      	domain_first = Domain.new(name: domain_now)
      	domain_first.users<<(@user)
      	domain_first.save
       
      	
      else
      	d_flag = 0
      	Domain.all.each do |d|
    		  if d.name == domain_now
    			 d.users<<(@user)
    			 d_flag = 1
    		  end
        end  
        if d_flag == 0
          domain_new = Domain.new(name: domain_now)
          domain_new.users<<(@user)
          domain_new.save
          
        
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
    if params[:set_admin]
      @user.toggle!(:admin)
      
    end
    if params[:roles_names]
      @roles = params[:roles_names]
      @roles.each do |r|
        if not @user.types.find_by_name(r)
          @user.types<<(@user.domain.types.find_by_name(r))
        end
      end    
    end
    redirect_to @user
  end
  def makeadmin
    @user = User.find(params[:id])
    if params[:set_admin]
      @user.toggle!(:admin)
      redirect_to correct_user
    end

  end
  def index
    @users = current_user.domain.users.paginate(page: params[:page]) 
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

  
end

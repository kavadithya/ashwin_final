class ElementsController < ApplicationController

	before_filter :admin_user, only: [:new, :create, :edit, :update]
	before_filter :permitted_user, only: [:show]
  def new
  	@element = current_user.domain.elements.new
  	@all_roles = @element.domain.types.all
  end

  def create
  	@element = current_user.domain.elements.new(params[:element])
  	@roles = params[:roles_names]

	if @element.save
		if @roles
    		@roles.each do |r|
        		@element.types<<(current_user.domain.types.find_by_name(r))
    		end  
    		
    	end
    	redirect_to elements_path
  	end
  end

  def show
  	@element = current_user.domain.elements.find(params[:id])
  	
  end

  def edit
  	@element = Element.find(params[:id])
  	@allowed_roles = @element.types.all
  	@remaining_roles = @element.domain.types.all - @allowed_roles
  end

  def update
  	@element = Element.find(params[:id])
  	@roles = params[:roles_names]
  	@element.types.clear
  	@roles.each do |r|
      	@element.types<<(Type.find(r))
    end  
    redirect_to elements_path
  end

  def index
  	@element = current_user.domain.elements.all
  end

  private
  	def permitted_user
  		flag = 0
  		@element = Element.find(params[:id])
  		current_user.types.each do |t|
  			t.elements.each do |u|
  				if u == @element
  					flag = 1
  				end
  			end
  		end
  		if current_user.admin?
  			flag = 1
  		end
  		redirect_to root_path unless flag==1
  	end


  	
end

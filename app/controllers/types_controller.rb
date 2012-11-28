class TypesController < ApplicationController

	before_filter :admin_user, only: [:new, :create, :show, :indexs]
	def new
		@type = current_user.domain.types.new
	end
	def create
		@type = current_user.domain.types.create(params[:type])
		redirect_to types_path
	end
	def edit
		@role = current_user.domain.types.find(params[:id]) 
		@all_elements = current_user.domain.elements.all
  		@added_elements = @role.elements.all
  		@remaining_elements = @all_elements - @added_elements
	end
	def show
		@type = current_user.domain.types.find(params[:id])
	end
	def index
		@role = current_user.domain.types.all
	end
	def update
		@elements = params[:elements_names]
		#@elements_yet = params[:elements_names_yet]
		@role = Type.find(params[:id])
		@role.elements.clear
		if not @elements.empty?
			@elements.each do |r|
				@role.elements<<(Element.find(r))
			end
		end
		redirect_to types_path

	end

end

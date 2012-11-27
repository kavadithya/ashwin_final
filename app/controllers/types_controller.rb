class TypesController < ApplicationController
	def new
		@type = current_user.domain.types.new
	end
	def create
		@type = current_user.domain.types.create(params[:type])
		redirect_to @type
		
	end
	def show
		@type = current_user.domain.types.find(params[:id])
	end
    def typeupdate
  	   redirect_to help_path
  	end

end

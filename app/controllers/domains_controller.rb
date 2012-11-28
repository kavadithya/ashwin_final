class DomainsController < ApplicationController
	before_filter :admin_user,     only: [:new, :main, :show]
	def new
	end

	def main
 	end

 	def show
 		@domain = Domain.find(params[:id])
 	end

 	
end

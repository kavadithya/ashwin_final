class DomainsController < ApplicationController
	def new
	end

	def main
 	end

 	def show
 		@domain = Domain.find(params[:id])
 	end
 	
end

class HomeController < ApplicationController
	def index
      render :layout => false
	end

	def authenticated
	  render 'authenticated', :layout => false
	end
end
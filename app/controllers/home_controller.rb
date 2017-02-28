class HomeController < ApplicationController
	skip_before_filter :permission
	def index
		
	end
end
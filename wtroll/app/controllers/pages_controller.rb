class PagesController < ApplicationController
	def custom_page
		if template_exists? params[:custom_page], "pages"
			render "pages/#{params[:custom_page]}"
		else
			raise ActionController::RoutingError.new 404
		end
	end

end

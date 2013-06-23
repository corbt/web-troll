class BooksController < ApplicationController
	respond_to :json

	def show
		render :index
	end

end

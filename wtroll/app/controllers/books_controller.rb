require 'ISBNdb'

class BooksController < ApplicationController
	respond_to :json

	def show
		@results = ISBNdb.search_books(params[:query])
		render :index
	end

end

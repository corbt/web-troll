require 'ISBNdb'

class BooksController < ApplicationController
	respond_to :json

	def show
		@results = ISBNdb.search_books(params[:query])
		@results.map! do |result|
			cached = Isbn.find_by_number(result[:isbn])
			cached ? cached.book.to_hash : result
		end
		render :index
	end

end	

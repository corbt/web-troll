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

	def reading_level

		@book = Book.new isbns: [Isbn.create(number:params[:isbn])]
		# @book.populate_from_wtroll
		@book.save
	end

	def create
		@book = Book.new new_book_params
		@book.save
		render format: :json
	end

	private
	def new_book_params
		# should be .require :isbn, but apparently .require with this format
		# is not currently supported.
		# github.com/rails/strong_parameters/issues/139
		params.permit(:isbn, :title, :url, :author, :author_url)
	end

end	

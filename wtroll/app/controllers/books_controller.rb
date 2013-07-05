require 'ISBNdb'

class BooksController < ApplicationController
	respond_to :json

	def show
		searcher = Openlibrary::Client.new

		raw_results = searcher.search(params[:query])
		@results = []
		raw_results.each do |result|
			if result.isbn #don't allow ISBN-less books into the results, can't use them anyway
				cached = result && result.isbn && result.isbn.first ? Isbn.find_by_number(result.isbn.first) : nil
				if not cached.nil?
					@results << cached.book
				else
					book = Book.new
					book.from_openlibrary result
					@results << book
				end
			end
		end
		render :index
	end

	def reading_level
		@book = Book.find(params[:book_id])
		@book.calculate_reading_level
		@book.save
	end

	def create
		@book = Book.new
		@book.from_isbn new_book_params[:isbn]
		@book.save
		render status: :created
	end
private
	
	def new_book_params
		# should be .require :isbn, but apparently .require with this format
		# is not currently supported.
		# github.com/rails/strong_parameters/issues/139
		params.permit(:isbn, :title, :url, :author, :author_url)
	end

end	

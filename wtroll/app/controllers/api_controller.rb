class ApiController < ApplicationController
	respond_to :json

	before_action :validate_key

	def reading_level
		@books = {}
		params[:isbns].split(',').each do |isbn|
			book = Book.from_isbn(isbn)
			book.calculate_reading_level @user
			@books[isbn] = Book.from_isbn(isbn).reading_hash
		end
		render json: @books
	end

	private
	def validate_key
		@user = User.find_by_api_key params[:key]
		unless @user
			render json: {error: "Your key appears to have failed. Visit the API docs for information on key generation and usage."}
		end
	end
end

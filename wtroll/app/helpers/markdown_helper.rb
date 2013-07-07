module MarkdownHelper
	def isbn arg
		"#{books_reading_level_url}.json?isbn=#{arg}"
	end

	def isbns arg
		"#{books_reading_level_url}.json?isbns=#{arg}"
	end
end
module MarkdownHelper
	def isbns arg
		"#{request.protocol}#{request.host_with_port}/api/v1/isbns/#{arg}/reading_level?key=[your_key]"
	end
	alias_method :isbn, :isbns
end
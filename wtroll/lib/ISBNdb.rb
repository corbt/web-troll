class ISBNdb
	def self.search_books query, page=1
		url = "http://isbndb.com/search/books/"+page.to_s+"?"+{query: query}.to_query
		doc = Nokogiri::HTML(HTTParty.get(url))

		self.parse_results(doc)		
	end

	def self.parse_results doc
		@results = Array.new
		doc.css('.bookSnippetBasic').each do |html|
			parsed = Hash.new
			parsed[:title] = html.css("h1").text.strip
			parsed[:url] = html.css("hgroup a").attribute("href").value
			parsed[:author] = html.css("div a").first.text.strip
			parsed[:author_url] = html.css("div a").attribute("href").value
			parsed[:isbn] = html.css('div span')[1].text[8..-1].strip
			@results << parsed
		end

		@results
	end
end
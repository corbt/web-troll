module Book::Errors
	BAD_FORMAT = "Malformatted ISBN: ISBN must be 10- or 13-digit number"
	NOT_FOUND	 = "No book was found on Openlibrary with this ISBN"
	NO_DATA		 = "Insufficient data on Worldcat to analyze the reading level of this book"
end
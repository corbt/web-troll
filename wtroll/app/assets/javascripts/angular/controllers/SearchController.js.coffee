angular.module('Troll').controller 'SearchController', ($scope, $http) ->
	$scope.runSearch = ->
		$scope.searchState = 'searching'

		$http({
			url: "/books.json"
			method: "GET"
			params: {query: $scope.query}
			})
		.success (data) ->
			$scope.results = data
			for book in $scope.results
				if book.reading_level
					book.readingState = 'found'
			$scope.searchState = 'success'
			$scope.$emit 'set_title', $scope.query+" | Trollie"

		.error () ->
			$scope.searchState = 'error'

	$scope.getReadingLevel = (book) ->
		book.readingState = 'searching'
		if not book.id
			postBook(book)

		else
			getReadingLevel(book)

	postBook = (book) ->
		$http({
			url: "/books.json"
			method: "POST"
			data: book
			})
		.success (data) ->
			book.id = data.id
			getReadingLevel(book) # TODO: switch to promise .then
		.error ->
		 	book.readingState = "error"

	getReadingLevel = (book) ->
		$http({
			url: "/books/"+book.id+"/reading_level.json"
			method: "GET"
			})
		.success (data) ->
			book.reading_level = data.reading_level
			book.readingState = "found"
		.error () ->
			book.readingState = "error"
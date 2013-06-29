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
		$http({
			url: "/books/reading_level"
			method: "GET"
			params: {isbn: book.isbn}
			})
		.success (data) ->
			book.reading_level = data
			book.readingState = 'found'
		.error () ->
			book.readingState = 'error'

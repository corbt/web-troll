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
			url: "/books.json"
			method: "POST"
			params: book
			})
		.success (data) ->
			book = data
			book.readingState = 'found'
		.error () ->
			book.readingState = 'error'

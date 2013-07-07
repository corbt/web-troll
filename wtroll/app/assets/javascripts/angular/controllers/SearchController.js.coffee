angular.module('Troll').controller 'SearchController', ($scope, $http, $timeout) ->
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
				if book.calculation_status == 1
					getReadingLevel(book)
			if data.length == 0
				$scope.searchState = 'noResults'
			else
				$scope.searchState = 'success'
			$scope.$emit 'set_title', $scope.query+" | Trollie"

		.error () ->
			$scope.searchState = 'error'

	$scope.getReadingLevel = (book) ->
		book.calculation_status = 1
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
		 	book.calculation_status = 3

	getReadingLevel = (book) ->
		$http({
			url: "/books/"+book.id+"/reading_level.json"
			method: "GET"
			})
		.success (data) ->
			if data.reading_level
				book.reading_level = data.reading_level 
				book.calculation_status = 2
			else if data.calculation_status == 3
				book.calculation_status = 3
			else if data.calculation_status == 1
				#TODO: this is what angularJS is supposed to avoid.  Refactor
				$timeout (-> getReadingLevel book), 3000
		.error () ->
			book.calculation_status = 3
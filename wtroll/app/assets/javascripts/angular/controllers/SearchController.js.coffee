angular.module('Troll').controller 'SearchController', ($scope, $http) ->
	$scope.runSearch = ->
		$scope.searchState = 'searching'

		$http.get("/books.json").success (data) ->
			$scope.searchState = 'success'
			$scope.results = data
			$scope.$emit 'set_title', $scope.query+" | Trollie"

		.error () ->
			$scope.searchState = 'error'
			console.log "failed"


	$scope.getReadingLevel = (book) ->
		console.log book
		book.readingLevel = 55
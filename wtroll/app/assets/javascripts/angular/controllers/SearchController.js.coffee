angular.module('Troll').controller 'SearchController', ($scope, $http) ->
	$scope.runSearch = ->
		$scope.searchState = 'searching'

		$http({
			url: "/books.json"
			method: "GET"
			params: {query: $scope.query}
			})
		.success (data) ->
			$scope.searchState = 'success'
			$scope.results = data
			$scope.$emit 'set_title', $scope.query+" | Trollie"

		.error () ->
			$scope.searchState = 'error'
			console.log "failed"


	$scope.getReadingLevel = (book) ->
		console.log book
		book.readingLevel = 55
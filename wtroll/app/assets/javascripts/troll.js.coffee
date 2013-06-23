window.App = angular.module('Troll', [])

App.run ($rootScope) ->
	$rootScope.title = "Trollie"
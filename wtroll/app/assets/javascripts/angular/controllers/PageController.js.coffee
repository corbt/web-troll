angular.module('Troll').controller 'PageController', ($scope) ->
	$scope.$on 'set_title', (e, newTitle) ->
		$scope.title = newTitle
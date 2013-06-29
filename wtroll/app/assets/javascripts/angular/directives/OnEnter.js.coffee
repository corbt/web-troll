angular.module('Troll').directive 'onEnter', ->
    (scope, element, attrs) ->
        element.bind "keydown keypress", ->
            if event.which == 13
                scope.$apply ->
                    scope.$eval attrs.onEnter
                event.preventDefault()
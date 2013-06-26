# angular.module('test', []).directive('onEnter', function() {
#         return function(scope, element, attrs) {
#             element.bind("keydown keypress", function(event) {
#                 if(event.which === 13) {
#                     scope.$apply(function(){
#                         scope.$eval(attrs.onEnter);
#                     });

#                     event.preventDefault();
#                 }
#             });
#         };
#     });

angular.module('Troll').directive 'onEnter', ->
    (scope, element, attrs) ->
        element.bind "keydown keypress", ->
            if event.which == 13
                scope.$apply ->
                    scope.$eval attrs.onEnter
                event.preventDefault()
angular.module('admin').directive 'myAutocomplete', [
  '$interval'
  '$parse'
  '$http'
   ($interval, $parse, $http) ->
     link = (scope, element, attrs) ->

        scope.setSelect = (item) ->
          scope.current = item
          scope.model = item.breadcrumb
          scope.selected = true

     {
       restrict: 'AE'
       transclude: true
       scope:
               items: '='
               model: '='
               selected: '='
               current: '='

       templateUrl: 'myAutocomplete.html'
       replace: true
       link: link
     }

]

angular.module('admin').filter 'searchBoldfilter', ->
  (input, query) ->
     input.breadcrumb.replace(RegExp('(' + query + ')', 'g'), '<span class="super-class">$1</span>')

angular.module('admin').directive 'myAutoAdditional', [
  '$interval'
  '$parse'
   ($interval, $parse) ->
     link = (scope, element, attrs, ngModel) ->
        element.on 'click', () ->
          scope.$apply () ->

                console.log('I m working')
                scope.selected = false
                ngModel.$parsers.push (data) ->

                  return data.length


                ngModel.$formatters.push (data) ->

                  return "3333"

                console.log(ngModel)


     {
       restrict: 'A'
       require : '?ngModel'
       scope: {}
       link: link
     }

]

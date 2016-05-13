angular.module("admin")
  .controller("ProductsController", [ "$scope", "$http", '$timeout',  ($scope, $http, $timeout) ->

    $scope.product = {}
    $scope.product.category = ""

    $scope.find_item = (category_id) ->
      if category_id
        angular.forEach($scope.items, (item) ->
          if item.id is category_id
            $scope.current = item
            $scope.product.category = item.breadcrumb
            $scope.selected = true
        )

    $scope.unSelected = ->
      $scope.selected = false

    $scope.remove = (index) ->
        $scope.p_attachs.splice(index, 1)




])

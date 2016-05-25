angular.module("admin")
  .controller("ProductsController", [ "$scope", "$http", '$timeout',  ($scope, $http, $timeout) ->

    $scope.product = {}
    $scope.product.category = ""

    $scope.find_item = (category_id) ->
      if category_id
        angular.forEach($scope.items, (item) ->
          if item.id is category_id
            $scope.current = item
            console.log("$scope.current", item)
            $scope.product.category = item.breadcrumb
            console.log("$scope.product.category", item.breadcrumb)
            $scope.selected = true
        )

    $scope.unSelected = ->
      $scope.selected = false

    $scope.remove = (index) ->
        $scope.p_attachs.splice(index, 1)

    $scope.isRemovable = ->
        return $scope.psizes.length > 0

    $scope.add = ->
        $scope.psizes.push({})

    $scope.remove_psize = (index) ->
        $scope.psizes.splice(index, 1)


])

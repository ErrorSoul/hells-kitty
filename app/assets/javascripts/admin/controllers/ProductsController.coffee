angular.module("admin")
  .controller("ProductsController", [ "$scope", "$http", '$timeout',  ($scope, $http, $timeout) ->

    $scope.product = {}
    $scope.product.category = ""
    $scope.foo = {bar: {id: '3', name: 'XL'}}

    $scope.find_item = (category_id) ->
      console.log('category_id', category_id)
      if category_id
        angular.forEach($scope.items, (item) ->
          console.log('item', item.id)
          if item.id is category_id
            $scope.current = item
            $scope.product.category = item.breadcrumb
            $scope.selected = true
        )
    $scope.equal = (size, psize) ->
      size.id is psize.size_id

    $scope.unSelected = ->
      $scope.selected = false

    $scope.remove = (index) ->
        $scope.p_attachs.splice(index, 1)
    $scope.remove_edit = (psize) ->
      psize._destroy = '1'

    $scope.isRemovable = ->
        return $scope.psizes.length > 0

    $scope.add = ->
        $scope.psizes.push({})

    $scope.remove_psize = (index) ->
        $scope.psizes.splice(index, 1)


])

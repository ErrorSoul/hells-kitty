angular.module("admin")
  .controller("ProductsController", [ "$scope", "$http", '$timeout',  ($scope, $http, $timeout) ->

    $scope.product = {}
    $scope.product.category = ""
    $scope.foo = {bar: {id: '3', name: 'XL'}}

    $scope.find_item = (category_id) ->
      if category_id
        angular.forEach($scope.items, (item) ->
          if item.id is category_id
            $scope.current = item
            $scope.product.category = item.breadcrumb
            $scope.selected = true
        )
    console.log("$", $scope)
    $scope.equal = (size, psize) ->
      console.log('size.id', size.id)
      console.log('psize.size_id', psize.size_id)
      console.log('><', size.id is psize.size_id)
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

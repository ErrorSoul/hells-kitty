angular.module('admin')
  .controller 'ModalInstanceCtrl',[ '$scope', '$http',  '$modalInstance', 'parent', ($scope, $http, $modalInstance, parent) ->

    $scope.category = {}
    $scope.category.parent_id = parent.id

    $scope.createCategory = ->
      $http.post('/api/v1/categories', category: $scope.category)
        .success (data) ->
          console.log(data, 'success')
          $modalInstance.close(data.category)
        .error (data) ->
          console.log(data)


    $scope.cancel = ->
      $modalInstance.dismiss 'cancel'
      return

    return
]

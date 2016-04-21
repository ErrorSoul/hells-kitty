angular.module('admin')
  .controller 'ModalEditInstanceCtrl',[ '$scope', '$http', '$modalInstance', 'category', ($scope, $http, $modalInstance, category) ->

    $scope.category = {}
    $scope.category.name = category.name
    $scope.category.id = category.id
    $scope.category.parent_id = category.parent_id

    $scope.createCategory = ->
      $http.patch("/api/v1/categories/#{$scope.category.id}",  category: $scope.category)
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

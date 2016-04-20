angular.module("admin")
  .controller("SessionController", [ "$scope", "$http", ($scope, $http) ->
    $scope.tab = 2
    $scope.user = {}
])

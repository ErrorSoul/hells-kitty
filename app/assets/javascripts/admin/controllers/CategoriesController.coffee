angular.module("admin")
  .controller("CategoriesController", [ "$scope", "$http", ($scope, $http) ->

    $scope.init = ->
      $http.get('/api/v1/categories').success (data) ->
        console.log(data, 'Data')
        $scope.categories = data.categories
        $scope.collapseAll()


    $scope.isCollapsed = (category) ->
      category.collapse

    $scope.collapsed = (category) ->
      category.collapse = !!!category.collapse


    $scope.collapseAll = ->
      $scope.iteration(true)

    $scope.expandAll = ->
       $scope.iteration(false)

    $scope.iteration = (flag) ->
      angular.forEach $scope.categories, (cat) ->
        cat.collapse = flag
        if $scope.isChildren(cat)
          angular.forEach cat.children, (child) ->
            child.collapse = flag
            console.log('child', child)


    $scope.isChildren = (category) ->
      category.children.length > 0

    $scope.init()
])

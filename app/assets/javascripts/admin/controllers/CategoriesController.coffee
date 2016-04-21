angular.module("admin")
  .controller("CategoriesController", [ "$scope", "$http","$uibModal", '$log', '$timeout',  ($scope, $http, $uibModal, $log, $timeout) ->

    $scope.init = ->
      $http.get('/api/v1/categories').success (data) ->
        console.log(data, 'Data')
        $scope.categories = data.categories
        $scope.collapseAll()


    $scope.showMessage = ->
      $timeout (->
        $scope.message = undefined
        return
      ), 9000

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


    $scope.isChildren = (category) ->
      category.children.length > 0


    $scope.animationsEnabled = true

    $scope.createCategory = (parent) ->
      modalInstance = $uibModal.open(
        animation: $scope.animationsEnabled
        templateUrl: 'myModalContent.html'
        controller: 'ModalInstanceCtrl'

        resolve: parent: ->
          parent
      )
      modalInstance.result.then ((selectedCategory) ->
        selectedCategory.collapse = true
        if parent.children is undefined
          parent.children = []
        parent.children.push(selectedCategory)
        $scope.message  = 'Категория успешно создана'
        $scope.showMessage()
        return
      ), ->
        $log.info 'Modal dismissed at: ' + new Date
        return
      return


    $scope.editCategory = (category) ->
      modalInstance = $uibModal.open(
        animation: $scope.animationsEnabled
        templateUrl: 'myModalContent.html'
        controller: 'ModalEditInstanceCtrl'

        resolve: category: ->
          category
      )
      modalInstance.result.then ((selectedCategory) ->
        selectedCategory.collapse = true
        category.name  = selectedCategory.name
        $scope.message  = 'Категория успешно обновлена'
        $scope.showMessage()
        return
      ), ->
        $log.info 'Modal dismissed at: ' + new Date
        return
      return

    $scope.deleteCategory = (parent, category) ->
      $http.delete("/api/v1/categories/#{category.id}")
        .success (data) ->
          $scope.message = "Категория успешно удалена"
          $scope.showMessage()
          index = parent.children.indexOf(category)
          parent.children.splice(index, 1);
        .error (data) ->
          console.log(data)

    $scope.init()
])

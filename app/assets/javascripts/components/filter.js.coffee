@Category = React.createClass
  getInitialState: ->
    status: ''
    category: @props.category
    breadcrumb: @props.breadcrumb || false

  categoryColor: ->
    if @props.currentCategory && @props.category.name is @props.currentCategory.name
      'red-color'
    else
      ''

  handleSubmit: (e)->
    if @state.status is 'active'
      new_status = ''
    else
      new_status = 'active'
    @props.onCategoryListUpdate(@props.category)
    #@setState status: new_status

  makeCategoryPath: ->
    console.log(@props.category.name, 'props.category.name')
    if @props.category.name
      "/#{@props.category.name}"
    else
      ""

  render: ->
    if @state.breadcrumb
      React.DOM.span
        className: @categoryColor()
        onClick: @handleSubmit
        @makeCategoryPath()
    else
      React.DOM.p
        className: @categoryColor()
        onClick: @handleSubmit
        @props.category.name

##################### BreadCrumbPanel ###########################

@BreadCrumbPanel = React.createClass(
  getInitialState: ->
    breadcrumb: true
  create: (category) ->
    categoriesFlatten = @props.categories

    makePath = (result, category, categoriesFlatten) ->
      if category.parent_id
        result.unshift category
        console.log 'if result', result
        find_category = _.find(categoriesFlatten, (cat) ->
          category.parent_id == cat.id
        )
        console.log 'find_category', find_category
        makePath result, find_category, categoriesFlatten
      else
        result.unshift category
      result

    makePath [], category, categoriesFlatten

  render: ->
    paths = @create(@props.category)
    React.DOM.p null,
      for path, index in paths
        React.createElement Category,
          key: index,
          category: path,
          breadcrumb: @state.breadcrumb,
          onCategoryListUpdate: @props.categoryHandler
          currentCategory: @props.category
  )

##################### CategoryList ###########################

@CategoryList = React.createClass
  getInitialState: ->
    categoriesFlatten = @flatten(@props.categories, [])
    return {
      category: @props.category
      data: @props.categories
      categoriesFlatten: categoriesFlatten
      currentCategories: @findCategories(@props.category, categoriesFlatten) || @props.categories
    }


  categoryHandler: (category) ->
    @setState({ currentCategories: (@findChildren(category) || @state.currentCategories), category: category})

  flatten: (array, result) ->
    _.each array, (element) =>
      if element.children
        result.push element
        @flatten element.children, result
      else
        result.push element
      return
    result

  findParent: (category, categories) ->
    _.find categories, (cat) ->
      cat.id == category.parent_id

  findSelf: (category, categories) ->
    _.find categories, (cat) ->
      cat.id == category.id

  findCategories: (category, categories) ->
    self = @findSelf(category, categories)
    if self
      return if self.children_count == 0 then @findParent(self, categories) else self.children
    false

  findChildren: (category) ->
    if category.children_count == 0 then false else category.children

  render: ->
    console.log('getInitialState', @state)
    React.DOM.div null,
      React.createElement BreadCrumbPanel,
        categoryHandler: @categoryHandler,
        category: @state.category,
        categories: @state.categoriesFlatten,
        currentCategory: @state.category
      React.DOM.ul
        categories: @state.categories
        for category, index in @state.currentCategories
          React.createElement Category,
            key: index,
            category: category,
            onCategoryListUpdate: @categoryHandler
            currentCategory: @state.category

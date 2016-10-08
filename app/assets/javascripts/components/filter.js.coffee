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


@hiddenField = React.createClass
  getInitialState: ->
    name: 'category_id'

  handlerCategory: ->
    if @props.category
      @props.category.id
    else
      ''
  render: ->
    React.DOM.input
      type: 'hidden'
      value: @handlerCategory()
##################### BreadCrumbPanel ###########################

@BreadCrumbPanel = React.createClass(
  getInitialState: ->
    breadcrumb: true
  create: (category) ->
    categoriesFlatten = @props.categories

    makePath = (result, category, categoriesFlatten) ->
      if category.parent_id
        result.unshift category
        find_category = _.find(categoriesFlatten, (cat) ->
          category.parent_id == cat.id
        )
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
##################### ProductView ###########################

@ProductView = React.createClass
  render: ->
    React.DOM.div
      className: 'thumbnail'
      React.DOM.a
        className: 'text-center product-link'
        href: "/admin/products/#{@props.product.id}"
        React.DOM.img
          className: 'img-responsive'
          src: @props.product.product_attachments[0].asset.url
      React.DOM.a
        className: 'text-center product-link'
        href: "/admin/products/#{@props.product.id}"
        React.DOM.h4
          className: 'text-center'
          @props.product.name
      React.DOM.p
        className: 'text-center category-line'
        @props.product.category.breadcrumb
      React.DOM.div
        className: 'caption'
        React.DOM.div
          className: 'col-xs-10 center-block'
          React.DOM.div
            className: 'head-attr'
            React.DOM.p
              className: 'text-center'
              'Артикул'
          React.DOM.div
            className: 'body-attr'
            React.DOM.p
              className: 'text-center'
              @props.product.marking
        React.DOM.div
          className: 'col-xs-10 center-block attr-block'
          React.DOM.div
            className: 'head-attr'
            React.DOM.p
              className: 'text-center'
              'Цена'
          React.DOM.div
            className: 'body-attr'
            React.DOM.p
              className: 'text-center'
              @props.product.price
      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'col-xs-12'
          for size, index in @props.product.sizes
            React.DOM.div
              key: index
              className: 'col-xs-4'
              React.DOM.span
                className: 'label label-size text-right'
                size.name
                #React.DOM.span
                  #className: 'label badge my-badge'
                  #size.value



##################### ProductList ###########################

@ProductList = React.createClass
  render: ->
    React.DOM.div
      className: 'row clearfix'
      for product, index in @props.products
          React.DOM.div
            key: index
            className: 'col-xs-12 col-lg-4'
            React.createElement ProductView,
              key: index,
              product: product


##################### CategoryList ###########################

@CategoryList = React.createClass
  getInitialState: ->
    categoriesFlatten = @flatten(@props.categories, [])
    return {
      category: @props.category
      initialCategory: @props.category
      data: @props.categories
      products: @props.products
      productStore: @props.products
      categoriesFlatten: categoriesFlatten
      currentCategories: @findCategories(@props.category, categoriesFlatten) || @props.categories
    }

  categoryHandler: (category) ->
    console.log 'state', @state
    $.post '/admin/products/search', { product_search: {category_id: category.id} }, (data) =>
      console.log('data', data)
      @setState({
        currentCategories: (@findChildren(category) || @state.currentCategories),
        category: category,
        products: data.products
      })

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

  updateCategory: ->
    console.log('category', @state.initialCategory)
    console.log('products', @state.productStore)
    console.log('categories', @state.categoriesFlatten)
    @setState(
      category: @state.initialCategory
      products: @state.productStore
      currentCategories: @state.data
    )

  render: ->
    React.DOM.div
      className: 'col-lg-12 col-xs-12',
      React.DOM.div
        className: 'col-xs-3',
        React.createElement hiddenField,
          value: @state.category
        React.DOM.p
          onClick: @updateCategory
          'Clear filters'
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
      React.DOM.div
        className: 'col-xs-9'
        React.createElement ProductList,
          products: @state.products

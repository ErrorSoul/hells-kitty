@LookInput = React.createClass
  getInitialState: ->
    name: @props.name || ''
    product: @props.product || {}

  handleSubmit: (e)->
    console.log('target value', e.target.value)
    @setState name: e.target.value
    @props.changeResults(e.target.value)

  getProductId: ->
    console.log('product', @state.product)
    if @state.product.name != undefined
      @state.product.id
    else
      ""

  render: ->
    React.DOM.div null,
      React.DOM.input
        onInput: @handleSubmit
        placeholder: 'Название'
        className: 'form-control'
        value: @state.name
      React.DOM.input
        type: 'hidden'
        id:   "look[product_id_#{@props.index}]"
        name: "look[product_id_#{@props.index}]"
        value: @getProductId()



@LookObject = React.createClass
  handleSubmit: ->
    console.log('product', @props.product)
    @props.onChangeName(@props.product)
    @props.ngHide()

  BolderFilter: (input, query) ->
    console.log('query', query)
    input.replace(RegExp('(' + query + ')', 'i'), '<span class="super-class">$1</span>')

  render: ->
      console.log('props s query', @props.query)
      React.DOM.div
        className: 'row look-slot'
        onClick: @handleSubmit
        React.DOM.div
          className: 'col-md-8'
          React.DOM.p
            name: @props.name
            className: 'media-heading'
            dangerouslySetInnerHTML: {__html: @BolderFilter(@props.name, @props.query)}
        React.DOM.div
          className: 'col-md-4'
          React.DOM.img
            className: 'img-responsive img-thumbnail'
            src:  @props.product.product_attachments[0].asset.url

@LookList = React.createClass
  getInitialState: ->
    hide: true
    query: @props.query
  ngHide: ->
    @setState hide: !@state.hide
  render: ->
    React.DOM.div
      className: 'col-md-12'
      React.DOM.div
        className: 'row'
        if @state.hide
          for product, index in @props.results
            React.createElement LookObject,
              key: index,
              name: product.name,
              product: product,
              onChangeName: @props.changeName,
              ngHide: @ngHide
              query: @props.query

@LookAutoComplete = React.createClass
  getInitialState: ->
    results: @props.results || []
    name: ''
    query: ''
    product: @props.results || {}

  onChangeResults: (name)->
    if name.length >= 3
      $.post '/admin/products/search', { product_search: {name: name} }, (data) =>
        @setState {results: data.products, query: name}
        @refs.lookList.setState({hide: true})
    else
      if name.length is 0
        @setState {results: [], query: name}
      else
        @setState {query: name}



  onChangeName: (product) ->
    @setState {name: product.name, product: product}
    @refs.lookInput.setState {name: product.name, product: product}

  render: ->
    React.DOM.div
      className: 'col-sm-3'
      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'col-md-12 look-preview'
          if @state.product.name is undefined
            React.DOM.img
              src: "http://placehold.it/265x360"
              className: 'img-responsive img-thumbnail'
          else
            React.DOM.img
              src: @state.product.product_attachments[0].asset.url
              className: 'img-responsive img-thumbnail'

      React.createElement LookInput,
        ref: "lookInput",
        index: @props.index,
        key: @props.index,
        changeResults: @onChangeResults,
        name: @state.product.name,
        product: @state.product
      React.createElement LookList, ref: 'lookList', results: @state.results, changeName: @onChangeName, query: @state.query


@LookFilter = React.createClass
  render: ->

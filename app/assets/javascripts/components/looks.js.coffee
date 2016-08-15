@LookInput = React.createClass
  getInitialState: ->
    name: @props.name || ''

  handleSubmit: (e)->
    console.log('target value', e.target.value)
    @setState name: e.target.value
    @props.changeResults(e.target.value)


  render: ->
    React.DOM.input
      onInput: @handleSubmit
      name: "look[product_id_#{@props.index}]"
      placeholder: 'Название'
      className: 'form-control'
      value: @state.name


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
      React.DOM.li
        className: 'media'
        onClick: @handleSubmit
        React.DOM.div
          className:"media-left"
          React.DOM.a
            href:"#"
            React.DOM.img
              className: "media-object img-responsive"
              src: @props.product.product_attachments[0].asset.url


        React.DOM.div
          className: 'media-body'
          React.DOM.h4
            name: @props.name
            className: 'media-heading'
            dangerouslySetInnerHTML: {__html: @BolderFilter(@props.name, @props.query)}


@LookList = React.createClass
  getInitialState: ->
    hide: true
    query: @props.query
  ngHide: ->
    @setState hide: !@state.hide
  render: ->
    React.DOM.div
      className: 'col-md-12'
      React.DOM.ul
        className: 'media-list'
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
    results: []
    name: ''
    query: ''
    product: {}

  onChangeResults: (name)->
    if name.length >= 3
      $.post '/admin/products/search', { product_search: {name: name} }, (data) =>
        console.log('data', data)
        console.log('name', name)
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
      React.createElement LookInput, ref: "lookInput", index: @props.index, key: @props.index, changeResults: @onChangeResults, name: @state.name, product: @state.product
      React.createElement LookList, ref: 'lookList', results: @state.results, changeName: @onChangeName, query: @state.query


@LookFilter = React.createClass
  render: ->

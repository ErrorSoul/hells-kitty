@ColorPanel = React.createClass
  getInitialState: ->
    color: @findColor(@props.color_id, @props.colors) || {id: "", code: ""}


  findColor: (color_id, colors) ->
    color = _.find(colors, (color) ->
      parseInt(color_id) is color.id)


  handleSubmit: (e)->
    @setState color: @findColor(e.target.value, @props.colors)
  setDestroy: (e) ->
    e.preventDefault()
    @setState _destroy: '1'

  checkHidden: ->
    if @state._destroy is '1'
       'hidden'
    else ""

  render: ->

    React.DOM.div
      className: "form-group #{@checkHidden()}"
      React.DOM.label
        className: 'col-sm-2 control-label'
      React.DOM.div
        className: 'col-sm-8'
        React.DOM.select
          onChange: @handleSubmit
          className: 'form-control'
          id: "product_color_color_id_#{@props.index}"
          name: "product[product_colors_attributes][#{@props.index}][color_id]"
          style: {backgroundColor: @state.color.code}
          value: @state.color.id
          React.DOM.option
            style: {backgroundColor: 'white'}
            value: ""
            "Выбрать цвет"
          for color, index  in @props.colors
            React.DOM.option
              key: index
              style: { backgroundColor: "#{color.code}"}
              value: color.id
              "#{color.code}"
      React.DOM.div
        className: 'col-sm-2'
        React.DOM.button
          className: 'btn btn-block btn-danger btn-remove'
          type: 'button'
          onClick: @setDestroy
          React.DOM.i
            className: "fa fa-close"

      React.DOM.input
        type: 'hidden'
        id: "product_color_id_#{@props.index}"
        name: "product[product_colors_attributes][#{@props.index}][id]"
        value: @props.id

      React.DOM.input
        type: 'hidden'
        id: "product_color__destroy_#{@props.index}"
        name: "product[product_colors_attributes][#{@props.index}][_destroy]"
        value: @state._destroy


@ColorForm = React.createClass
  getInitialState: ->
    productColors: @props.product_colors

  addProductColor: ->
    p_colors = @state.productColors
    p_colors.push {color_id: ""}
    @setState productColors: p_colors
  render: ->
    React.DOM.div null,
      for p_color, index in @state.productColors
        React.createElement ColorPanel, key: index, color_id: p_color.color_id, id: p_color.id, colors: @props.colors, index: index
      React.createElement ColorButton, add_panel: @addProductColor


@ColorButton = React.createClass
  onhandleSubmit: ->
    console.log('dfdfasdf')
    @props.add_panel()
  render: ->
     React.DOM.button
       className: "btn btn-block btn-success"
       type: "button"
       onClick: @onhandleSubmit
       "Добавить"

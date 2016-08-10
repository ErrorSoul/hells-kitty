@LookInput = React.createClass

  handleSubmit: (e)->

    @props.changeResults()
  render: ->

    React.DOM.input
      onChange: @handleSubmit
      name: "look[product_id_#{@props.index}]"
      placeholder: 'Название'
      className: 'form-control'
      value: @props.name




@LookObject = React.createClass
  handleSubmit: ->
    console.log('im working')
    @props.onChangeName(@props.name)
    console.log('name', @props.name)
  render: ->
      React.DOM.li
        className: 'media'
        onClick: @handleSubmit
        React.DOM.div
          className: 'media-body'
          React.DOM.div
            name: @props.name
            className: 'media-heading'
            'ddfdfdfsadfasdf'


@LookList = React.createClass
  render: ->
    React.DOM.div
      className: 'col-md-12'
      React.DOM.ul
        className: 'media-list'
        for c in @props.results
          React.createElement LookObject, key: c, name: c, onChangeName: @props.changeName

@LookAutoComplete = React.createClass
  getInitialState: ->
    results: []
    name: ''

  onChangeResults: ->
    @setState results: [1, 2, 3, 4, 5]

  onChangeName: (name) ->
    console.log('onchangeName working')
    console.log(name, 'onchange name')
    @setState name: name
    console.log(@state.name, 'state name')

  render: ->
    React.DOM.div
      className: 'col-sm-3'
      React.createElement LookInput, index: @props.index, key: @props.index, changeResults: @onChangeResults, name: @state.name
      React.createElement LookList, results: @state.results, changeName: @onChangeName

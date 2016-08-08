@LookInput = React.createClass
  render: ->
    React.DOM.div
      className: 'col-sm-3'
      React.DOM.input
        name: "look[product_id_#{@props.index}]"
        placeholder: 'Название'
        className: 'form-control'

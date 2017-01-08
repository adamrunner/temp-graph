@Entry = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.entry.created_at
      React.DOM.td null, temperatureFormat(@props.entry.temperature)

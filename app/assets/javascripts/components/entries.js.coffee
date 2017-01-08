@Entries = React.createClass
    getInitialState: ->
      entries: @props.data.entries
      sensor: @props.data.sensor
    getDefaultProps: ->
      entries: []
      sensor: []
    render: ->
      React.DOM.div
        className: 'entries'
        React.DOM.h2
          className: 'title'
          "Entries for #{@state.sensor.name}"
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Date'
              React.DOM.th null, 'Temperature'
          React.DOM.tbody null,
            for entry in @state.entries
              React.createElement Entry, key: entry.id, entry: entry

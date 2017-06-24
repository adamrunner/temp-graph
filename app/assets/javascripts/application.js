// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require mqttws31
//= require tether
//= require moment
//= require highcharts
//= require lodash
//= require bootstrap-sprockets
//= require_tree .

var mqttDisconnectedAlert = '<div class="alert alert-danger" role="alert"><strong>Uh oh! </strong>Cannot connect to MQTT Server, reload the page.</div>';
$(function(){
  $('button[data-toggle-show], a[data-toggle-show], input[data-toggle-show]').each(function() {
    $(this).on('click', function() {
      var selectorToToggle;
      selectorToToggle = "#" + $(this).data('toggle-show');
      $(selectorToToggle).toggleClass('hidden');
    });
  });
});


window.updateArrivedAt = {};


function outputUpdate(value) {
	document.querySelector('#outputLedValue').value = value;
}

// Create a client instance
function mqttConnect() {
  client = new Paho.MQTT.Client("temp.adamrunner.com", Number(1200), "rails-app" + window.session_id);
  // set callback handlers
  client.onConnectionLost = onConnectionLost;
  client.onMessageArrived = onMessageArrived;
  // connect the client
  client.connect({onSuccess:onConnect, useSSL: true});
}


$(function(){
  mqttConnect();
  $(".update").click(function(e){
    $(this).find(".fa").addClass("fa-spin");
    e.preventDefault();
    console.log("requesting update");
    $.post("/request_update")
    message = new Paho.MQTT.Message("1");
    message.destinationName = "TEMP_REQ";
    client.send(message);
    $(this).blur();
  });

  $('[data-mqtt-topic]').on('click', function(event){
    event.preventDefault();
    $(this).blur();
    var topic   = $(this).data('mqtt-topic');
    var value   = $(this).data('mqtt-value').toString();
    var message = new Paho.MQTT.Message(value);
    message.destinationName = topic;
    client.send(message);
  });

  $(".mqttForm").on("submit", function(event){
    event.preventDefault();
    var value = $(event.target).find('.mqttMessage:checked').val() || $(event.target).find('.mqttMessage').val()
    var message = new Paho.MQTT.Message(value);
    message.destinationName = $(event.target).find('input:hidden').val();
    client.send(message);
  })
})

// called when the client connects
function onConnect() {
  // Once a connection has been made, make a subscription and send a message.
  console.log("onConnect");
  client.subscribe("outTopic");
	client.subscribe("debugMessages");
}

// called when the client loses its connection
function onConnectionLost(responseObject) {
  if (responseObject.errorCode !== 0) {
		$(".container").prepend(mqttDisconnectedAlert);
    console.log("onConnectionLost:"+responseObject.errorMessage);
    client.connect({onSuccess:onConnect, useSSL: true});
  }
}

// called when a message arrives
function onMessageArrived(message) {
  // %Y-%m-%d %H:%I:%S
  $(".fa-spin").removeClass("fa-spin");
  // regex to see what type of message we see
  // stopping pump
  // starting pump
  // ssss,dd.dd
  // LED
  if(message.payloadString.match(/PSU,ON/)){
		$("#psuForm").find("#mqttMessage_1").prop("checked", true);
    $("#psuForm").find("#mqttMessage_0").prop("checked", false);
  }

	if(message.payloadString.match(/PSU,OFF/)){
    $("#psuForm").find("#mqttMessage_1").prop("checked", false);
    $("#psuForm").find("#mqttMessage_0").prop("checked", true);
  }

  if(message.payloadString.match(/PUMP,OFF/)){
    $(".water_pump").removeClass("spinner")
  }
  if(message.payloadString.match(/PUMP,ON/)){
    $(".water_pump").addClass("spinner")
  }

  if(message.payloadString.match(/ESP_.+/)){
    var sensorId, temp;
    sensorId = message.payloadString.split(",")[0];
    temp     = message.payloadString.split(",")[1];
    updateArrivedAt[sensorId] = moment().clone();
    var timestampText = updateArrivedAt[sensorId].format("YYYY-MM-DD HH:mm:ss");
    $sensorEl = $("#" + sensorId);
    $sensorEl.find(".temp_value").text(temp);
    var intervalID = window.setInterval(updateTimeAgo, 30000, sensorId);
    $sensorEl.find(".time_ago").text(updateArrivedAt[sensorId].fromNow());
    $sensorEl.find(".timestamp").text(timestampText);
  }
  if(message.payloadString.match(/LED.+/)){
    var ledValue = message.payloadString.split(",")[1]
    outputUpdate(ledValue);
    var opacity = parseInt(ledValue, 10) / 1024
    $("#plantLedBulb").css({opacity: opacity})
  }
  console.log("onMessageArrived:"+message.payloadString);
}

function updateTimeAgo(sensorId) {
  var $sensorEl = $("#" + sensorId)
  $sensorEl.find(".time_ago").text(updateArrivedAt[sensorId].fromNow());
}

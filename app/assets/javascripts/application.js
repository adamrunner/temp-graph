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
//= require moment
//= require_tree .

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
    message = new Paho.MQTT.Message("1");
    message.destinationName = "TEMP_REQ";
    client.send(message);
    $(this).blur();
  });

  $(".mqttForm").on("submit", function(event){
    event.preventDefault();
    var value = $(event.target).find('.mqttMessage:checked').val() || $(event.target).find('.mqttMessage').val()
    message = new Paho.MQTT.Message(value);
    message.destinationName = $(event.target).find('input:hidden').val();
    client.send(message);
  })
})

// called when the client connects
function onConnect() {
  // Once a connection has been made, make a subscription and send a message.
  console.log("onConnect");
  client.subscribe("outTopic");
}

// called when the client loses its connection
function onConnectionLost(responseObject) {
  if (responseObject.errorCode !== 0) {
    console.log("onConnectionLost:"+responseObject.errorMessage);
    client.connect({onSuccess:onConnect, useSSL: true});
  }
}

// called when a message arrives
function onMessageArrived(message) {
  // %Y-%m-%d %H:%I:%S
  $(".fa-spin").removeClass("fa-spin");
  var timestampText = moment().format("YYYY-MM-DD HH:mm:ss");
  var sensorId, temp;
  sensorId = message.payloadString.split(",")[0];
  temp     = message.payloadString.split(",")[1];
  $sensorEl = $("#" + sensorId);
  $sensorEl.find(".temp").text(temp);
  //TODO: make this dynamically updating
  // $sensorEl.find(".time_ago").text("")
  $sensorEl.find(".timestamp").text(timestampText);

  console.log("onMessageArrived:"+message.payloadString);
}

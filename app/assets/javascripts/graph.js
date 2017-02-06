Highcharts.setOptions({
  //TODO: this should be dynamic from the web app
    global: {
        timezoneOffset: 8 * 60
    }
});

$(function () {
  var chartOptions = {
    chart: {
      zoomType: 'x'
    },
    title: {
      text: 'Temperature Over Time'
    },
    subtitle: {
      text: document.ontouchstart === undefined ?
            'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
    },
    xAxis: {
      type: 'datetime'
    },
    yAxis: {
      title: {
        text: 'Temperature Over Time'
      }
    },
    legend: {
      enabled: true
    },
    plotOptions: {
    }
  }
  chartOptions.series = []

  _.each(window.chartData, function(value, key){
    chartOptions.series.push({
      type: 'line',
      name: key,
      data: value
    });
  });

  drawChart(chartOptions);
  configureControls();
});

function drawChart(chartOptions){
  Highcharts.chart('tempChart', chartOptions);
}

function configureControls(){
  //TODO: Move this to backbone after I decide how it will work
  var $from       = $("#from");
  var $to         = $("#to");
  var $resolution = $("#resolution");
  var $perPage    = $("#per_page");
  var $go         = $("#go");
  var $backDay    = $("#minus-one-day");
  var $forwardDay = $("#add-one-day");
  var $yesterday  = $("#yesterday");
  var $today      = $("#today");

}

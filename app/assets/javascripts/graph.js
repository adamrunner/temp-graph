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
  chartOptions.series = [
    {
      type: 'line',
      name: 'PDX Weather',
      data: window.chartData["Outside"]
    },
    {
      type: 'line',
      name: 'Inside Temperature - Kitchen',
      data: window.chartData["ESP_0BA4E4"]
    },
    {
      type: 'line',
      name: 'Inside Temperature - Living Room',
      data: window.chartData["ESP_E2106F"]
    },
    {
      type: 'line',
      name: 'Outside Sensor',
      data: window.chartData["ESP_299021"]
    },
  ]

  drawChart(chartOptions);
});

function drawChart(chartOptions){
  Highcharts.chart('tempChart', chartOptions);
}

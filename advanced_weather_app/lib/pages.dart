import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'classes.dart';
import 'functions.dart';
import 'package:intl/intl.dart';

IconData getWeatherIcon(int number) {
  switch (number) {
    case 0:
      return Icons.wb_sunny; // Clear sky
    case 1:
      return Icons.wb_sunny; // Mainly clear
    case 2:
      return Icons.cloud_queue; // Partly cloudy
    case 3:
      return Icons.cloud; // Overcast
    case 45:
    case 48:
      return Icons.dehaze; // Fog / Depositing rime fog
    case 51:
    case 53:
    case 55:
      return Icons.grain; // Light to dense drizzle
    case 56:
    case 57:
      return Icons.ac_unit; // Freezing drizzle
    case 61:
    case 63:
    case 65:
      return Icons.umbrella; // Light to heavy rain
    case 66:
    case 67:
      return Icons.ac_unit; // Freezing rain
    case 71:
    case 73:
    case 75:
      return Icons.ac_unit; // Snowfall
    case 77:
      return Icons.snowing; // Snow grains (or fallback to ac_unit)
    case 80:
    case 81:
    case 82:
      return Icons.umbrella; // Rain showers
    case 85:
    case 86:
      return Icons.ac_unit; // Snow showers
    case 95:
      return Icons.flash_on; // Slight thunderstorm
    case 96:
    case 99:
      return Icons.bolt; // Thunderstorm with hail
    default:
      return Icons.help_outline; // Undefined weather
  }
}

class CurrentPage extends StatelessWidget {
  const CurrentPage({
    super.key,
    required this.toDisplay,
    required this.toDisplayCurrent,
    required this.weather_code,
  });

  final String             toDisplay;
  final List<String> toDisplayCurrent;
  final int weather_code;

  @override
  Widget build(BuildContext context) {
    List<Widget> toDisplayCurrentPage(int weather_code){
      if (toDisplayCurrent.isEmpty) {
        return  [Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // horizental
          children: [Text(toDisplay, style: TextStyle(fontSize: 21, color: Colors.white70)),]
        )];
      }
      if (toDisplayCurrent.length < 4) {
        return [
          for (var each in toDisplayCurrent)
            Text(each, style: TextStyle(fontSize: 21, color: Colors.white),)
        ];
      }
      int count = 0;
      return [
        Text (toDisplayCurrent[count++], style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.blue)),
        if (toDisplayCurrent.length == 6)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.white54,),
              Text (toDisplayCurrent[count++], style: TextStyle(fontSize: 19, color: Colors.white70)),],
          ),
        Text (toDisplayCurrent[count++], style: TextStyle(fontSize: 19, color: Colors.white70)),
        Text (""), Text (""), Text (""),
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.thermostat, color: Colors.orange, size: 60,),
            Text (toDisplayCurrent[count++], style: TextStyle(fontSize: 37, color: Colors.orange,)),]
        ),
        Text (""), Text (""),
        Text (toDisplayCurrent[count++], style: TextStyle(fontSize: 21, color: Colors.white)),
        Icon(
          getWeatherIcon(weather_code), 
          color: Colors.blue,
          size: 60,),
        Text (""), Text (""),
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.air, color: Colors.blue, size: 35,),
            Text (toDisplayCurrent[count++], style: TextStyle(fontSize: 21, color: Colors.white,)),]
        ),
      ];
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // horizental
      children: toDisplayCurrentPage(weather_code),
    );
  }
}


class TodayPage extends StatelessWidget {
  TodayPage({
    super.key,
    required this.toDisplay,
    required this.toDisplayToday,
    required this.chartDataToday
  });

  final String             toDisplay;
  final List<String> toDisplayToday;
  final List<InHourData>? chartDataToday;
  final ScrollController _scrollController = ScrollController();
  @override
  void depose() {
    _scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

  List<Widget> toDisplayTodayPage()
  {
    int count = 0;
    if (toDisplayToday.isEmpty) {
        return  [Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // horizental
          children: [Text(toDisplay, style: TextStyle(fontSize: 21, color: Colors.white70)),]
        )];
      }
      if (toDisplayToday.length < 4) {
        return [
          for (var each in toDisplayToday)
            Text(each, style: TextStyle(fontSize: 21, color: Colors.white),)
        ];
      }
    return [
      Text (toDisplayToday[count++], style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.blue)),
      if (toDisplayToday.length == 29)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white54,),
            Text (toDisplayToday[count++], style: TextStyle(fontSize: 19, color: Colors.white70)),],
        ),
      Text (toDisplayToday[count++], style: TextStyle(fontSize: 19, color: Colors.white70)),
      Row (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.today, color: Colors.orange, size: 19,),
          Text (toDisplayToday[count++], style: TextStyle(fontSize: 19, color: Colors.orange,)),]
      ),
      Text(""),
      SfCartesianChart(
        backgroundColor: const Color.fromARGB(70, 119, 87, 55),
        title: ChartTitle(
          text: 'Today temperatures',
          textStyle: TextStyle(color: Colors.white70)),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          StackedLineSeries<InHourData, int>(
            dataSource:   chartDataToday!,
            xValueMapper: (InHourData exp, _)=> exp.hour,
            yValueMapper: (InHourData exp, _)=> exp.temperature_2m,
            markerSettings:  MarkerSettings(isVisible: true),
            color: Colors.orange
            ),
        ],
        primaryXAxis: NumericAxis(
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel('${details.value.toString().padLeft(2, '0')}:00', TextStyle(color: Colors.white70));
          },
        ),
        primaryYAxis: NumericAxis(
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel('${details.value.toStringAsFixed(0)}°C', TextStyle(color: Colors.white70));
          },
        ),
      ),
      Text(""),
      Text(""),
      Container(
        height: 230,
        color: const Color.fromARGB(70, 119, 87, 55),
        child: ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(const Color.fromARGB(100, 119, 87, 55)),
            trackColor: WidgetStateProperty.all(const Color.fromARGB(100, 255, 255, 255)),),
          child: Scrollbar(
            controller: _scrollController,
              trackVisibility: true,
              thickness: 7.0,
              radius: Radius.circular(8.0), 
            child: ListView.builder(
            controller: _scrollController,
            itemCount: chartDataToday!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return (
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${chartDataToday![index].hour.toString().padLeft(2, '0')}:00', style:  TextStyle(color: Colors.white70),),
                      Text(""),
                      Text(getWeatherDescription(chartDataToday![index].weather_code)!, style:  TextStyle(fontSize: 12, color: Colors.white70),),
                      Icon(getWeatherIcon(chartDataToday![index].weather_code), color: Colors.blue, size: 25,),
                      Text(""),
                      Text('${chartDataToday![index].temperature_2m}°C', style: TextStyle(fontSize: 21, color: Colors.orange,)),
                      Text(""),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.air, color: Colors.white, size: 18,),
                          Text (' ${chartDataToday![index].wind_speed_10m}km/h', style: TextStyle(fontSize: 15, color: Colors.white,)),]
                      ),
                    ],
                  )
                )
              );
            })
          )
        )
      ),
    ];
  }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // horizental
      children: toDisplayTodayPage());
  }
}

class WeekPage extends StatelessWidget {
  WeekPage({
    super.key,
    required this.toDisplay,
    required this.toDisplayWeek,
    required this.chartDataWeek,
    required this.screenWidth,
  });

  final String             toDisplay;
  final List<String>       toDisplayWeek;
  final List<WeekData>?      chartDataWeek;
  final double screenWidth;
  final ScrollController _scrollController = ScrollController();

  @override
  void depose() {
    _scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    List<Widget> toDisplayWeekPage()
    {
      int count = 0;
      if (toDisplayWeek.isEmpty)
      {
        return [Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // horizental
          children: [
            Text(toDisplay, style: TextStyle(fontSize: 21)),
          ]
        )];
      }
      return [
        Text (toDisplayWeek[count++], style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.blue)),
        if (toDisplayWeek.length == 10)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.white54,),
              Text (toDisplayWeek[count++], style: TextStyle(fontSize: 19, color: Colors.white70)),],
          ),
        Text (toDisplayWeek[count++], style: TextStyle(fontSize: 19, color: Colors.white70)),
        Text(""),
        SfCartesianChart(
          backgroundColor: const Color.fromARGB(70, 119, 87, 55),
          title: ChartTitle(
            text: 'Weekly temperatures',
            textStyle: TextStyle(color: Colors.white70)),
            legend: Legend(
              isVisible: true,
              textStyle: TextStyle(color: Colors.white60),
              position: LegendPosition.bottom),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries>[
            LineSeries<WeekData, String>(
              dataSource:   chartDataWeek!,
              xValueMapper: (WeekData exp, _)=> exp.dayMonth,
              yValueMapper: (WeekData exp, _)=> exp.max,
              markerSettings:  MarkerSettings(isVisible: true),
              color: Colors.red,
              name: "Max temperatur"
            ),
            LineSeries<WeekData, String>(
              dataSource:   chartDataWeek!,
              xValueMapper: (WeekData exp, _)=> exp.dayMonth,
              yValueMapper: (WeekData exp, _)=> exp.min,
              markerSettings:  MarkerSettings(isVisible: true),
              color: Colors.blue,
              name: "Min temperatur"
            ),
          ],
          primaryXAxis: CategoryAxis(
            labelStyle: TextStyle(color: Colors.white70)
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              return ChartAxisLabel('${details.value.toStringAsFixed(0)}°C', TextStyle(color: Colors.white70));
            },
          ),
        ),
        Text(""),
        Container (
          child: Container(
            height: 230,
            color: const Color.fromARGB(70, 119, 87, 55),
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                thumbColor: WidgetStateProperty.all(const Color.fromARGB(100, 119, 87, 55)),
                trackColor: WidgetStateProperty.all(const Color.fromARGB(100, 255, 255, 255)),
              ), 
              child: Scrollbar(
                controller: _scrollController,
                trackVisibility: true,
                thickness: 7.0,
                radius: Radius.circular(8.0), 
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chartDataWeek!.length,
                  scrollDirection: Axis.horizontal,
                  padding: screenWidth > 600 ? EdgeInsets.symmetric(horizontal: (screenWidth - 600) / 2) : EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, index) {
                    return (
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${chartDataWeek![index].dayMonth}', style:  TextStyle(color: Colors.white70),),
                            Text(""),
                            Text(getWeatherDescription(chartDataWeek![index].weather_code)!, style:  TextStyle(fontSize: 12, color: Colors.white70),),
                            Icon(getWeatherIcon(chartDataWeek![index].weather_code), color: Colors.blue, size: 45,),
                            Text(""),
                            Text('${chartDataWeek![index].max}°C', style: TextStyle(fontSize: 21, color: Colors.red,)),
                            Text('${chartDataWeek![index].min}°C', style: TextStyle(fontSize: 21, color: Colors.blue,)),
                            Text(""),
                          ],
                        )
                      )
                    );
                  }
                ),
              )
            )
          ),
        ),
      ];
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // horizental
      children: toDisplayWeekPage(),
    );
  }
}

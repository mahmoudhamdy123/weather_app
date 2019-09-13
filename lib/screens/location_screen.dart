import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String typedName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = ' ';
        return;
      }
      double temp = weatherData['main']['temp'];
      double celsius = temp - 273.15;
      print(celsius);
      print(temp);
      temperature = celsius.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: FlatButton(
          onPressed: () async {
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          child: Icon(
            Icons.add_location,
            color: Colors.blue,
            size: 40,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Alert(
                style: alertStyle,
                  context: context,
                  title: "City Name",
                  content: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.location_city),
                          labelText: 'City Name',
                        ),
                        onChanged: (value){
                          typedName = value;
                        },
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () async {
                        if (typedName != null)  {
                          var weatherData = await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                        Navigator.pop(context);
                        },
                      child: Text(
                        "Get Weather",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]).show();
            },
            child: Icon(
              Icons.location_city,
              size: 40.0,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.9
                          : MediaQuery.of(context).size.width * 0.7,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.2
                          : MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Temperature',
                        style: kTempTextStyle,
                      ),
                      CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: temperature / 100,
                        center: new Text(
                          "$temperature°",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                ),
                child: Container(
                  alignment: Alignment.center,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.9
                          : MediaQuery.of(context).size.width * 0.7,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.4,
                  child: Text(
                    '$weatherMessage in $cityName',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

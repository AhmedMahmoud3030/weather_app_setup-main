import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
              icon: Icon(Icons.search),
            ),
          ],
          title: Text('Weather App'),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<WeatherCubit>(context);
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherSuccess) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    cubit.weatherModel!.getThemeColor(),
                    cubit.weatherModel!.getThemeColor()[300]!,
                    cubit.weatherModel!.getThemeColor()[100]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      BlocProvider.of<WeatherCubit>(context).cityName!,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'updated at : ${(cubit.weatherModel)!.date.hour.toString()}:${(cubit.weatherModel)!.date.minute.toString()}',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset((cubit.weatherModel)!.getImage()),
                        Text(
                          (cubit.weatherModel)!.temp.toInt().toString(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                                'maxTemp :${(cubit.weatherModel)!.maxTemp.toInt()}'),
                            Text(
                                'minTemp : ${(cubit.weatherModel)!.minTemp.toInt()}'),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      (cubit.weatherModel)!.weatherStateName,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              );
            } else if (state is WeatherFailed) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'there is no weather 😔 start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'searching now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start search now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}

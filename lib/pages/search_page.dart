import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search a City'),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<WeatherCubit>(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (data) {
                    cubit.cityName = data;
                  },
                  onSubmitted: (data) async {
                    cubit.getWeather(cityName: cubit.cityName!);
                    Navigator.pop(context);
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    label: Text('search'),
                    suffixIcon: GestureDetector(
                        onTap: () async {
                          WeatherService service = WeatherService();

                          WeatherModel? weather = await service.getWeather(
                              cityName: cubit.cityName!);

                          cubit.weatherModel = weather;

                          Navigator.pop(context);
                        },
                        child: Icon(Icons.search)),
                    border: OutlineInputBorder(),
                    hintText: 'Enter a city',
                  ),
                ),
              ),
            );
          },
        ));
  }
}

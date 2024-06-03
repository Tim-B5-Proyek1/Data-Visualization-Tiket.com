import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:data_visualization_b5/widgets/landing_template_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DataVisualization());
}

class DataVisualization extends StatefulWidget {
  const DataVisualization({super.key});

  @override
  State<DataVisualization> createState() => _DataVisualizationState();
}

class _DataVisualizationState extends State<DataVisualization> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FlightProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LandingProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const LandingTemplateWidget(),
        );
      }),
    );
  }
}

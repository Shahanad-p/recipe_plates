import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';

class PieChartPageWidget extends StatelessWidget {
  PieChartPageWidget({super.key});

  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = [
    Colors.greenAccent,
  ];
  List ChartRecpie = recipeNotifier.value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          title: const Text(
            'Cost Chart',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Text(
                'Total Cost',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                valueListenable: recipeNotifier,
                builder: (context, value, child) {
                  double totalCost = calculateTotalCost(value);
                  return Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 233, 233),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        '₹ ${totalCost.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: recipeNotifier,
                builder: (context, value, child) {
                  return SizedBox(
                    height: 500,
                    child: PieChart(
                      PieChartData(
                        sections: List.generate(
                          ChartRecpie.length,
                          (index) {
                            double cost = double.parse(ChartRecpie[index].cost);
                            double totalCost = calculateTotalCost(value);
                            double percentage = (cost / totalCost) * 100;
                            final name = ChartRecpie[index].name;

                            return PieChartSectionData(
                              badgePositionPercentageOffset: 1.1,
                              titlePositionPercentageOffset: .4,
                              color: getRandomColor(),
                              value: percentage,
                              title: '''₹ ${cost.toStringAsFixed(2)}
      (${percentage.toStringAsFixed(2)}%)
      $name
      ''',
                              radius: 95,
                              titleStyle: const TextStyle(
                                fontSize: 13.10,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            );
                          },
                        ),
                        sectionsSpace: 3,
                        centerSpaceRadius: 80,
                        startDegreeOffset: 10,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double calculateTotalCost(List<recipeModel> recipes) {
  double totalCost = 0;
  for (var recipe in recipes) {
    totalCost += double.parse(recipe.cost);
  }
  return totalCost;
}

Color getRandomColor() {
  return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}

// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates/functions/functions.dart';


class PieChartPageWidget extends StatelessWidget {
  PieChartPageWidget({Key? key});

  final List<Color> fixedColors = [
    Colors.amber,
    Colors.pinkAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.tealAccent,
    Colors.purpleAccent,
    Colors.lightGreenAccent,
    Colors.indigoAccent,
    Colors.amberAccent,
  ];

  List ChartRecpie = recipeNotifier.value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: const Text(
              'Cost Chart',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
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
                    if (ChartRecpie.isEmpty) {
                      return SizedBox(
                        height: 500,
                        child: Center(
                          child: Lottie.asset(
                            'assets/Animation - 1703942875916.json',
                            height: 150,
                            width: 150,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 500,
                        child: PieChart(
                          PieChartData(
                            sections: List.generate(
                              ChartRecpie.length,
                              (index) {
                                double cost =
                                    double.parse(ChartRecpie[index].cost);
                                double totalCost = calculateTotalCost(value);
                                double percentage = (cost / totalCost) * 100;
                                final name = ChartRecpie[index].name;
                                final category = ChartRecpie[index].category;

                                return PieChartSectionData(
                                  color:
                                      fixedColors[index % fixedColors.length],
                                  value: percentage,
                                  title: '''  ₹ ${cost.toStringAsFixed(2)}
          ${percentage.toStringAsFixed(2)}%
         $name 
         $category
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
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

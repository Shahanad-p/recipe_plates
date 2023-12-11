import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartPageWidget extends StatelessWidget {
  PieChartPageWidget({Key? key}) : super(key: key);

  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300, // Set the desired height
                child: PieChart(
                  PieChartData(
                    sections: getSections(),
                    centerSpaceRadius: 65,
                    // centerText: "Flutter",
                    // // Optional: Center text in the middle of the pie chart
                    // colorList: [colorList[0]], // Use color directly from the list
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return dataMap.keys.map((String key) {
      final value = dataMap[key]!;
      return PieChartSectionData(
        color: colorList[0], // Use color directly from the list
        value: value,
        title: '$value',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    }).toList();
  }
}

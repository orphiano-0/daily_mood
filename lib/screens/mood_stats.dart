import 'package:daily_moode/shared/widgets/ranking_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../shared/widgets/mood_navigation.dart';

class MoodStats extends StatelessWidget {
  const MoodStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wow')),
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _chartTwo(),

            Container(
              width: double.infinity,
              height: 300,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RankingBar(
                      title: "Secondary",
                      color: Colors.grey,
                      heightFactor: 0.7,
                    ),
                    RankingBar(
                      title: "Leading",
                      color: Colors.amber,
                      heightFactor: 1.0,
                    ),
                    RankingBar(
                      title: "Third",
                      color: Colors.brown,
                      heightFactor: 0.5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox _chartTwo() {
  return SizedBox(
    width: double.infinity,
    height: 250,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Text('STATS'),
        PieChart(
          duration: Duration(microseconds: 750),
          curve: Curves.easeInOut,
          PieChartData(
            sections: [
              // Item 1
              PieChartSectionData(value: 10, color: Colors.blue),
              // Item 2
              PieChartSectionData(value: 30, color: Colors.redAccent),
              // Item 3
              PieChartSectionData(value: 10, color: Colors.amberAccent),
              // Item 4
              PieChartSectionData(value: 20, color: Colors.deepOrange),
            ],
          ),
        ),
      ],
    ),
  );
}

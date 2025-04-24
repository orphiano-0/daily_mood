import 'package:daily_moode/features/mood_entry/models/mood_model.dart';
import 'package:daily_moode/features/mood_entry/mood_entry_bloc.dart';
import 'package:daily_moode/features/mood_entry/mood_entry_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/widgets/mood_navigation.dart';

class MoodStats extends StatelessWidget {
  const MoodStats({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STATISTICS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Pixel', // Use a pixelated font for retro style
          ),
        ),
        backgroundColor:
            Colors.blueGrey.shade900, // Dark background for retro feel
        centerTitle: true,
        elevation: 0, // Flat look
      ),
      backgroundColor: const Color.fromARGB(
        255,
        20,
        20,
        20,
      ), // Dark gray for contrast
      body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 12.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _chartTwo(),
                    const SizedBox(height: 20),
                    _barChart(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
    );
  }

  Container _barChart() {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 30), // Slightly lighter gray
        border: Border.all(color: Colors.white, width: 2), // Bold white outline
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _rankingBar("SECONDARY", Colors.grey, 0.7),
          _rankingBar("LEADING", Colors.amber, 1.0),
          _rankingBar("THIRD", Colors.brown, 0.5),
        ],
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
        const Text(
          'MOOD DISTRIBUTION',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pixel', // Blocky font
            color: Colors.white,
          ),
        ),
        PieChart(
          PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 50,
            sections: [
              PieChartSectionData(
                value: 25,
                color: Colors.blue,
                title: '25%',
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pixel', // Retro font
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 35,
                color: Colors.redAccent,
                title: '35%',
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pixel',
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 20,
                color: Colors.amberAccent,
                title: '20%',
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pixel',
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 20,
                color: Colors.deepOrange,
                title: '20%',
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pixel',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Expanded _rankingBar(String title, Color color, double heightFactor) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 250 * heightFactor,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white, width: 2), // Bold outline
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pixel', // Retro font
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

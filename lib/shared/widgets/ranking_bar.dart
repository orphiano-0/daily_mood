import 'package:flutter/material.dart';

class RankingBar extends StatelessWidget {
  final String title;
  final Color color;
  final double heightFactor;

  const RankingBar({super.key,
    required this.title,
    required this.color,
    required this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 50,
          // height: MediaQuery.of(context).size.height * 0.3 * heightFactor,
          height: heightFactor * 90,
          color: color,
        ),
      ],
    );
  }
}

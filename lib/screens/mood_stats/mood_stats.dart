import 'package:daily_moode/features/mood_entry/models/mood_model.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/screens/utils/emoji_categories.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../features/mood_entry/models/mood_models.dart';
import '../../shared/widgets/mood_navigation.dart';

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
        backgroundColor: Colors.blueGrey.shade900, // Dark background for retro feel
        centerTitle: true,
        elevation: 0, // Flat look
      ),
      backgroundColor: const Color.fromARGB(255, 20, 20, 20), // Dark gray for contrast
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state is MoodLoaded) {
            final moods = state.entry;

            // Process moods for distribution calculation
            final moodDistribution = _calculateMoodDistribution(moods);

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 12.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildMonthlyTitle(),
                    const SizedBox(height: 19),
                    _buildMoodPieChart(moodDistribution),
                    const SizedBox(height: 20),
                    _moodHistorySection(moods),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      ),
    );
  }

  Widget _buildMonthlyTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 30),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'MONTHLY DISTRIBUTION',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMoodPieChart(List<MapEntry<String, double>> distribution) {
    // Colors for different mood categories
    final Map<String, Color> categoryColors = {
      "Happy": Colors.amber,
      "Sad": Colors.blue,
      "Angry": Colors.redAccent,
      "Calm": Colors.green,
      "Anxious": Colors.purple,
      "Excited": Colors.orange,
      "Others": Colors.grey,
    };

    return SizedBox(
      width: double.infinity,
      height: 250, // Adjust the height as needed
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 200, // Set a fixed width for the pie chart
          height: 200, // Set a fixed height for the pie chart
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 40, // Adjust the center space radius
              sections: distribution.map((entry) {
                final String label = entry.key;
                final double percentage = entry.value;
                final Color color = categoryColors[label] ?? Colors.grey;

                return PieChartSectionData(
                  value: percentage,
                  color: color,
                  title: '${percentage.toStringAsFixed(0)}%',
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pixel',
                    color: Colors.white,
                  ),
                  radius: 60, // Adjust the radius to fit within the box
                  titlePositionPercentageOffset: 0.6,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _moodHistorySection(List<MoodModel> moods) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 30),
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'MOOD DISTRIBUTION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pixel',
                color: Colors.white,
              ),
            ),
          ),
          if (moods.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No moods recorded yet.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Pixel',
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: moods.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white24,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final mood = moods[index];
                final emojiCategory = EmojiCategory.fromEmojiId(mood.emojiId);
                final formattedDate = DateFormat('MMM d, yyyy - HH:mm').format(mood.timeStamp);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: emojiCategory.color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: emojiCategory.color, width: 2),
                        ),
                        child: Image.asset(emojiCategory.image),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  emojiCategory.label,
                                  style: TextStyle(
                                    color: emojiCategory.color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Pixel',
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 8,
                                    fontFamily: 'Pixel',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mood.moodLog,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Pixel',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // Calculate distribution percentages from the mood data
  List<MapEntry<String, double>> _calculateMoodDistribution(List<MoodModel> moods) {
    if (moods.isEmpty) {
      // Return default distribution if no moods exist
      return [
        MapEntry('Happy', 0),
        MapEntry('Sad', 0),
        MapEntry('Angry', 0),
        MapEntry('Others', 0),
      ];
    }

    // Filter for current month's entries
    final now = DateTime.now();
    final currentMonthMoods = moods.where((mood) {
      final moodDate = mood.timeStamp;
      return moodDate.year == now.year && moodDate.month == now.month;
    }).toList();

    // If no entries for current month, use all entries
    final moodsToUse = currentMonthMoods.isEmpty ? moods : currentMonthMoods;

    // Count occurrences of each mood category
    final Map<String, int> categoryCount = {};
    for (final mood in moodsToUse) {
      final category = EmojiCategory.fromEmojiId(mood.emojiId).label;
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    // Sort by count (descending)
    final sortedCategories = categoryCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Take top 3 categories, group the rest as "Others"
    final topCategories = sortedCategories.take(3).toList();
    final totalCount = moodsToUse.length;
    final topCategoriesCount = topCategories.fold<int>(0, (sum, entry) => sum + entry.value);
    final othersCount = totalCount - topCategoriesCount;

    // Calculate percentages
    final result = topCategories.map((entry) {
      final percentage = (entry.value / totalCount) * 100;
      return MapEntry(entry.key, percentage);
    }).toList();

    // Add "Others" category if there are any leftover moods
    if (othersCount > 0) {
      final othersPercentage = (othersCount / totalCount) * 100;
      result.add(MapEntry('Others', othersPercentage));
    }

    return result;
  }
}
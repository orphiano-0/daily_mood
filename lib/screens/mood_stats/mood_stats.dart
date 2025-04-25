import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/screens/utils/emoji_categories.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../features/mood_entry/models/mood_models.dart';

class MoodStats extends StatelessWidget {
  const MoodStats({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MoodBloc>().add(LoadMoodEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STATISTICS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Pixel',
          ),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        elevation: 0, // Flat look
      ),
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state is MoodLoaded) {
            final moods = state.entry;
            final currentMonthDistribution = _calculateMoodDistribution(moods);
            final lastMonthDistribution =
                _calculateMoodDistributionForLastMonth(moods, 1);
            final lastTwoMonthDistribution =
                _calculateMoodDistributionForLastMonth(moods, 2);

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 12.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        _buildMoodPieChart(currentMonthDistribution),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            !lastMonthDistribution.isEmpty
                                ? _buildLastMonthPieChart(lastMonthDistribution)
                                : Text(
                                  'No Data\nLast month',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Pixel',
                                    fontSize: 10,
                                  ),
                                ),
                            const SizedBox(height: 20),
                            !lastTwoMonthDistribution.isEmpty
                                ? _buildLastMonthPieChart(
                                  lastTwoMonthDistribution,
                                )
                                : Text(
                                  'No Data\nLast 2 months',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Pixel',
                                    fontSize: 10,
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),
                    // _buildMonthlyTitle(),
                    // const SizedBox(height: 19),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: const Text(
        'MONTHLY DISTRIBUTION',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _moodHistorySection(List<MoodModel> moods) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
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
              ),
            ),
          ),
          if (moods.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No moods recorded yet.',
                  style: TextStyle(fontFamily: 'Pixel'),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: moods.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final mood = moods[index];
                final emojiCategory = EmojiCategory.fromEmojiId(mood.emojiId);
                final formattedDate = DateFormat(
                  'MMM d, yyyy',
                ).format(mood.timeStamp);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
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
                          border: Border.all(
                            color: emojiCategory.color,
                            width: 2,
                          ),
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
                                    fontSize: 8,
                                    fontFamily: 'Pixel',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mood.moodLog,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
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

  Widget _buildMoodPieChart(List<MapEntry<String, double>> distribution) {
    // Colors for different mood categories
    final Map<String, Color> categoryColors = {
      "Happy": Color(0xffFFD700),
      "Worried": Color(0xff6EB9EF),
      "Angry": Color(0xffFF6767),
      "Good": Color(0xffA7F3D0),
      "Confused": Color(0xffFCA5A5),
      "Horrible": Color(0xffC0B2C3),
      "Others": Color(0xff6BBC46),
    };

    return Expanded(
      child: Column(
        children: [
          _buildMonthlyTitle(),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            height: 200, // Adjust the height as needed
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 200, // Set a fixed width for the pie chart
                height: 200, // Set a fixed height for the pie chart
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 40, // Adjust the center space radius
                    sections:
                        distribution.map((entry) {
                          final String label = entry.key;
                          final double percentage = entry.value;
                          final Color color =
                              categoryColors[label] ?? Colors.grey;

                          return PieChartSectionData(
                            value: percentage,
                            color: color,
                            title: '${percentage.toStringAsFixed(0)}%',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pixel',
                            ),
                            radius: 60,
                            titlePositionPercentageOffset: 0.6,
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastMonthPieChart(List<MapEntry<String, double>> distribution) {
    if (distribution == null) {
      return const Text(
        'No entry this month',
        style: TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
      );
    }
    return Column(
      children: [
        Text(
          'Last Month',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pixel',
          ),
        ),
        SizedBox(
          width: 180,
          height: 180,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 30,
              sections:
                  distribution.map((entry) {
                    final String label = entry.key;
                    final double percentage = entry.value;

                    // Colors for different mood categories
                    final Map<String, Color> categoryColors = {
                      "Happy": Color(0xffFFD700),
                      "Worried": Color(0xff6EB9EF),
                      "Angry": Color(0xffFF6767),
                      "Good": Color(0xffA7F3D0),
                      "Confused": Color(0xffFCA5A5),
                      "Horrible": Color(0xffC0B2C3),
                      "Others": Color(0xff6BBC46),
                    };
                    final Color color = categoryColors[label] ?? Colors.grey;

                    return PieChartSectionData(
                      value: percentage,
                      color: color,
                      title: '${percentage.toStringAsFixed(0)}%',
                      titleStyle: const TextStyle(
                        fontSize: 10, // Use smaller font
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pixel',
                      ),
                      radius: 40,
                      titlePositionPercentageOffset: 0.5,
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<MapEntry<String, double>> _calculateMoodDistribution(
    List<MoodModel> moods,
  ) {
    if (moods.isEmpty) {
      return [
        MapEntry('Happy', 0),
        MapEntry('Sad', 0),
        MapEntry('Angry', 0),
        MapEntry('Others', 0),
      ];
    }

    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1);

    final currentMonthMoods =
        moods.where((mood) {
          final moodDate = mood.timeStamp;
          return moodDate.year == now.year && moodDate.month == now.month;
        }).toList();

    if (currentMonthMoods.isEmpty) {
      return [
        MapEntry('Happy', 0),
        MapEntry('Sad', 0),
        MapEntry('Angry', 0),
        MapEntry('Others', 0),
      ];
    }

    final moodsToUse = currentMonthMoods.isEmpty ? moods : currentMonthMoods;

    final Map<String, int> categoryCount = {};
    for (final mood in moodsToUse) {
      final category = EmojiCategory.fromEmojiId(mood.emojiId).label;
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    final sortedCategories =
        categoryCount.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    final topCategories = sortedCategories.take(3).toList();
    final totalCount = moodsToUse.length;
    final topCategoriesCount = topCategories.fold<int>(
      0,
      (sum, entry) => sum + entry.value,
    );
    final othersCount = totalCount - topCategoriesCount;

    final result =
        topCategories.map((entry) {
          final percentage = (entry.value / totalCount) * 100;
          return MapEntry(entry.key, percentage);
        }).toList();

    if (othersCount > 0) {
      final othersPercentage = (othersCount / totalCount) * 100;
      result.add(MapEntry('Others', othersPercentage));
    }
    return result;
  }

  List<MapEntry<String, double>> _calculateMoodDistributionForLastMonth(
    List<MoodModel> moods,
    int month,
  ) {
    if (moods.isEmpty) {
      return [];
    }

    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - month);

    final lastMonthMoods =
        moods.where((mood) {
          final moodDate = mood.timeStamp;
          return moodDate.year == lastMonth.year &&
              moodDate.month == lastMonth.month;
        }).toList();

    if (lastMonthMoods.isEmpty) {
      return []; // No data for last month
    }

    final moodsToUse = lastMonthMoods.isEmpty ? moods : lastMonthMoods;

    final Map<String, int> categoryCount = {};
    for (final mood in moodsToUse) {
      final category = EmojiCategory.fromEmojiId(mood.emojiId).label;
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    final sortedCategories =
        categoryCount.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    final topCategories = sortedCategories.take(3).toList();
    final totalCount = moodsToUse.length;
    final topCategoriesCount = topCategories.fold<int>(
      0,
      (sum, entry) => sum + entry.value,
    );
    final othersCount = totalCount - topCategoriesCount;

    // Calculate percentages
    final result =
        topCategories.map((entry) {
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

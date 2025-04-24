import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/screens/utils/emoji_categories.dart';

class MoodHistory extends StatelessWidget {
  const MoodHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MOOD DIARY',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pixel',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state is MoodLoaded) {
            final moods = state.entry;

            if (moods.isEmpty) {
              return const Center(
                child: Text(
                  'NO MOODS YET',
                  style: TextStyle(
                    fontFamily: 'Pixel',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              );
            }

            List<Widget> moodWidgets = [];
            DateTime? lastDate;

            for (int i = 0; i < moods.length; i++) {
              final mood = moods[i];
              final currentDate = DateTime(
                mood.timeStamp.year,
                mood.timeStamp.month,
                mood.timeStamp.day,
              );

              if (lastDate == null || currentDate.isAfter(lastDate)) {
                // Add a date divider before this mood
                moodWidgets.add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        '— ${DateFormat.yMMMMd().format(mood.timeStamp).toUpperCase()} —',
                        style: const TextStyle(
                          fontFamily: 'Pixel',
                          fontSize: 10,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                );
                lastDate = currentDate;
              }

              // Add the mood card
              moodWidgets.add(_pixelatedCard(mood));
            }

            return ListView(
              padding: const EdgeInsets.all(12),
              children: moodWidgets,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _pixelatedCard(dynamic mood) {
    final emoji = EmojiCategory.fromEmojiId(mood.emojiId);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: emoji.color,
        border: Border.all(color: Colors.black, width: 4),
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(emoji.image, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emoji.label.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Pixel',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mood.moodLog,
                  style: const TextStyle(
                    fontFamily: 'Pixel',
                    fontSize: 10,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat('hh:mm a').format(mood.timeStamp),
                    style: const TextStyle(
                      fontFamily: 'Pixel',
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

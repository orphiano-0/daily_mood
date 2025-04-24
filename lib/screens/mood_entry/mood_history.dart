// import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
// import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
// import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/screens/utils/emoji_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodHistory extends StatelessWidget {
  const MoodHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state is MoodLoaded) {
            final moods = state.entry;

            if (moods.isEmpty) {
              return const Center(child: Text('No moods added yet.'));
            }

            return ListView.builder(
              itemCount: moods.length, // Ensure this reflects the full list
              itemBuilder: (context, index) {
                final mood = moods[index];
                return Card(
                  child: ListTile(
                    // EmojiCategory (assets - label - color)
                    leading: Image.asset(EmojiCategory.fromEmojiId(mood.emojiId).image),
                    title: Text(EmojiCategory.fromEmojiId(mood.emojiId).label),
                    // moodLog (text) - timeStamp (date)
                    subtitle: Text(mood.moodLog),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
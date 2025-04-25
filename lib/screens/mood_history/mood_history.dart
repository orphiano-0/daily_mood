import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
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
    context.read<MoodBloc>().add(LoadMoodEvent());
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
          if (state is MoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoodLoaded) {
            final moods = state.entry;
            if (moods.isEmpty) {
              return const Center(
                child: Text(
                  'NO MOODS YET',
                  style: TextStyle(
                    fontFamily: 'Pixel',
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
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
              moodWidgets.add(_pixelatedCard(context, mood));
            }

            return ListView(
              padding: const EdgeInsets.all(12),
              children: moodWidgets,
            );
          } else if (state is MoodFailed) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _pixelatedCard(BuildContext context, dynamic mood) {
    final String text = mood.moodLog;
    final emoji = EmojiCategory.fromEmojiId(mood.emojiId);
    final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier(false);
    final exceedsMaxLines = text.length > 100;

    return Dismissible(
      key: Key(mood.moodId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        context.read<MoodBloc>().add(DeleteMoodEvent(mood.moodId));

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('note deleted')));
      },
      child: Container(
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
                  // Text(
                  //   mood.moodLog,
                  //   style: const TextStyle(
                  //     fontFamily: 'Pixel',
                  //     fontSize: 10,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isExpandedNotifier,
                    builder: (context, isExpanded, child) {
                      return Text(
                        text,
                        style: const TextStyle(
                          fontFamily: 'Pixel',
                          fontSize: 10,
                          color: Colors.black87,
                        ),
                        maxLines: isExpanded ? null : 2,
                        overflow: isExpanded ? null : TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  if (exceedsMaxLines)
                    TextButton(
                      onPressed: () {
                        _isExpandedNotifier.value = !_isExpandedNotifier.value;
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // Removes padding
                        minimumSize:
                            Size.zero, // Removes default button minimum size
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        overlayColor: Colors.transparent,
                      ),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isExpandedNotifier,
                        builder: (context, isExpanded, child) {
                          return Text(
                            isExpanded ? 'Read Less' : 'Read More',
                            style: TextStyle(
                              fontFamily: 'Pixel',
                              fontSize: 9,
                              color: const Color.fromARGB(255, 88, 102, 195),
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
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
      ),
    );
  }
}

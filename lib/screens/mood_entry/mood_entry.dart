import 'package:daily_moode/features/carousel_bloc/carousel_state.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:daily_moode/shared/widgets/mood_button.dart';
import 'package:daily_moode/shared/widgets/mood_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../features/carousel_bloc/carousel_bloc.dart';
import '../../features/carousel_bloc/carousel_event.dart';
import '../utils/emoji_categories.dart';

class MoodEntry extends StatelessWidget {
  MoodEntry({super.key});

  TextEditingController journalController = TextEditingController();

  List<Widget> carouselItem =
      EmojiCategory.values
          .skip(1)
          .map(
            (emojiCategory) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset(emojiCategory.image, fit: BoxFit.fill),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    emojiCategory.label,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
          .toList();

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(1);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SliderBloc, SliderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final EmojiCategory currentCategory = EmojiCategory.fromEmojiId(
            state.currentSliderIndex,
          );
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: currentCategory.color,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: ValueListenableBuilder<int>(
                        valueListenable: _currentIndexNotifier,
                        builder: (context, currentIndex, child) {
                          return PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              _currentIndexNotifier.value = index;
                              context.read<SliderBloc>().add(
                                SliderOnChanged(currentSliderIndex: index + 1),
                              );
                            },
                            children:
                                EmojiCategory.values.skip(1).map((category) {
                                  return _carouselItem(category.image);
                                }).toList(),
                          );
                        },
                      ),
                    ),
                    Text(
                      currentCategory.label,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Pixel'),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    MoodJournalEntry(journalEntry: journalController),
                    SizedBox(height: 20),
                    MoodButton(
                      color: currentCategory.color,
                      text: 'Mood Entry',
                      onPressed: () async {
                        // open box
                        final moodBox = Hive.box<MoodModel>('daily_moods');
                        final moodEntry = MoodModel(
                          moodId: moodBox.length + 1,
                          emojiId: _currentIndexNotifier.value + 1,
                          moodLog: journalController.text,
                          timeStamp: DateTime.now(),
                        );

                        await moodBox.add(moodEntry);

                        print("Saved Entry: ${moodEntry.toString()}");
                        print("All Mood Entries: ${moodBox.values.toList()}");

                        context.read<MoodBloc>().add(AddMoodEvent(moodEntry));
                        context.read<MoodBloc>().add(LoadMoodEvent());

                        journalController.clear();

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Mood entry saved!')),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _carouselItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath),
      ),
    );
  }
}

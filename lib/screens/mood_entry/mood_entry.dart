import 'package:daily_moode/features/carousel_bloc/carousel_state.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:daily_moode/shared/widgets/mood_button.dart';
import 'package:daily_moode/shared/widgets/mood_snackbar.dart';
import 'package:daily_moode/shared/widgets/mood_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../features/carousel_bloc/carousel_bloc.dart';
import '../../features/carousel_bloc/carousel_event.dart';
import '../utils/emoji_categories.dart';

class MoodEntry extends StatefulWidget {
  MoodEntry({super.key});

  @override
  _MoodEntryState createState() => _MoodEntryState();
}

class _MoodEntryState extends State<MoodEntry> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController journalController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SliderBloc, SliderState>(
        listener: (context, state) {
          // You can handle side effects here, if needed.
          final int emojiId = state.currentSliderIndex ?? 1;
          print('Updated ID: ${emojiId}');
        },
        builder: (context, state) {
          int currentSliderIndex = state.currentSliderIndex ?? 1;
          final int emojiCount = EmojiCategory.values.length - 1;

          if (currentSliderIndex < 1) currentSliderIndex = 1;
          if (currentSliderIndex > emojiCount) currentSliderIndex = emojiCount;

          final EmojiCategory currentCategory = EmojiCategory.fromEmojiId(
            currentSliderIndex,
          );

          print('Emoji Category: ${currentCategory.emojiId}');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              _pageController.jumpToPage(currentSliderIndex - 1);
            }
          });

          return Form(
            key: _formKey,
            child: Container(
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
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            context.read<SliderBloc>().add(
                              SliderOnChanged(currentSliderIndex: index + 1),
                            );
                          },
                          children:
                              EmojiCategory.values.skip(1).map((category) {
                                return _carouselItem(category.image);
                              }).toList(),
                        ),
                      ),

                      Text(
                        currentCategory.label,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pixel',
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF8EF),
                          border: Border.all(
                            color: const Color(0xFF222222),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: TextFormField(
                          controller: journalController,
                          maxLines: 9,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Write your journal entry here...",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Pixel',
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Pixel',
                            fontWeight: FontWeight.w600,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      MoodButton(
                        color: currentCategory.color,
                        text: 'Mood Entry',
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(MoodSnackBar.create('Bullshit'));
                            print('Empty');
                            return;
                          } else {
                            print('Not Empty');
                          }

                          // Proceed only when valid
                          final moodBox = Hive.box<MoodModel>('daily_moods');
                          final emojiId =
                              context
                                  .read<SliderBloc>()
                                  .state
                                  .currentSliderIndex;
                          final moodEntry = MoodModel(
                            moodId: moodBox.length + 1,
                            emojiId: emojiId,
                            moodLog: journalController.text.trim(),
                            timeStamp: DateTime.now(),
                          );

                          context.read<MoodBloc>().add(AddMoodEvent(moodEntry));
                          context.read<MoodBloc>().add(LoadMoodEvent());

                          journalController.clear();

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(MoodSnackBar.create('Mood saved!'));
                        },
                      ),
                    ],
                  ),
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

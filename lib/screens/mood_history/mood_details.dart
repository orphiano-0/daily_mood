import 'package:daily_moode/features/carousel_bloc/carousel_state.dart';
import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:daily_moode/screens/utils/emoji_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../features/carousel_bloc/carousel_bloc.dart';

class MoodDetails extends StatelessWidget {
  final int moodId;
  MoodDetails({super.key, required this.moodId});

  final TextEditingController journalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final moodBox = Hive.box<MoodModel>('daily_moods');
    final MoodModel? moodEntry = moodBox.get(moodId);
    final emoji = EmojiCategory.fromEmojiId(moodEntry!.emojiId);

    if (moodEntry != null) {
      journalController.text = moodEntry.moodLog;
    }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/diary'),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<SliderBloc, SliderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: emoji.color,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: Hero(tag: 'dash', child: Image.asset(emoji.image)),
                    ),
                    Text(
                      emoji.label.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pixel',
                      ),
                    ),
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
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Pixel',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Pixel',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

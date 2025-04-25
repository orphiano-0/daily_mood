import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:daily_moode/features/settings_bloc/settings_bloc.dart';
import 'package:daily_moode/features/settings_bloc/settings_event.dart';
import 'package:daily_moode/features/settings_bloc/settings_state.dart';
import 'package:daily_moode/shared/widgets/confirmation_dialog.dart';
import 'package:daily_moode/shared/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class SettingsMood extends StatelessWidget {
  const SettingsMood({super.key});

  @override
  Widget build(BuildContext context) {
    Box<MoodModel> moodBox = Hive.box<MoodModel>('daily_moods');

    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        final themeBloc = BlocProvider.of<SettingBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'SETTINGS',
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
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SettingsButton(
                      text: 'Light Mode',
                      icon: Icons.light_mode,
                      // color: Colors.orangeAccent.shade200,
                      onPressed: () {
                        themeBloc.add(LightThemeSelected());
                        print('Theme: ${LightThemeSelected}');
                      },
                    ),
                    const SizedBox(width: 10),
                    SettingsButton(
                      text: 'Dark Mode',
                      icon: Icons.dark_mode,
                      onPressed: () {
                        themeBloc.add(DarkThemeSelected());
                        print('Theme: ${DarkThemeSelected}');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  text: 'Delete All',
                  icon: Icons.delete,
                  // color: Colors.transparent,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          text: 'Are you sure you want to proceed?',
                          onPressed: () {
                            moodBox.clear();
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  text: 'Team',
                  icon: Icons.bubble_chart_rounded,
                  // color: Colors.redAccent,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
